import 'package:consulta_cep_flutter/controllers/endereco-controller.dart';
import 'package:consulta_cep_flutter/models/localizacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../exceptions/api-invalida-exception.dart';
import '../exceptions/cep-invalido-exception.dart';
import '../exceptions/cep-nao-encontrado-exception.dart';
import '../models/endereco.dart';

/// Máscara 00000-000
class _CepFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitos = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limitado = digitos.length > 8 ? digitos.substring(0, 8) : digitos;
    final texto = limitado.length > 5
        ? '${limitado.substring(0, 5)}-${limitado.substring(5)}'
        : limitado;
    return TextEditingValue(
      text: texto,
      selection: TextSelection.collapsed(offset: texto.length),
    );
  }
}

class EnderecoView extends StatefulWidget {
  const EnderecoView({super.key});

  @override
  State<StatefulWidget> createState() => _EnderecoViewState();
}

class _EnderecoViewState extends State<EnderecoView> {
  final _cepController = TextEditingController();
  final _enderecoController = EnderecoController();

  Endereco? endereco;

  Localizacao? localizacao;

  bool _carregando = false;
  String? _mensagemErro;
  Endereco? _endereco;

  Future<void> _consultar() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _carregando = true;
      _mensagemErro = null;
      _endereco = null;
    });

    try {
      final cep = _enderecoController.validaCEP(_cepController.text);
      final endereco = await _enderecoController.buscarEndereco(cep);
      final localizacao = await _enderecoController.buscarLocalizacao(cep);

      setState(() {
        this.localizacao = localizacao;
        this.endereco = endereco;
      });

      
      setState(() => _endereco = endereco);
    } on CepInvalidException catch (e) {
      setState(() => _mensagemErro = e.toString());
    } on CepNaoEncontradoException catch (e) {
      setState(() => _mensagemErro = e.toString());
    } on ApiInvalidaException catch (e) {
      setState(() => _mensagemErro = e.toString());
    } catch (e) {
      setState(() => _mensagemErro = 'Erro inesperado: $e');
    } finally {
      setState(() => _carregando = false);
    }
  }

  void _limpar() {
    _cepController.clear();
    setState(() {
      _mensagemErro = null;
      _endereco = null;
      _carregando = false;
    });
  }

  @override
  void dispose() {
    _cepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta CEP'),
        centerTitle: true,
        backgroundColor: cores.primaryContainer,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _cabecalho(cores),
                const SizedBox(height: 24),
                _formulario(),
                const SizedBox(height: 24),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _resultado(cores),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cabecalho(ColorScheme cores) => Column(
    children: [
      CircleAvatar(
        radius: 36,
        backgroundColor: cores.primaryContainer,
        child: Icon(Icons.location_on, size: 40, color: cores.primary),
      ),
      const SizedBox(height: 12),
      Text(
        'Encontre um endereço',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 4),
      Text(
        'Digite o CEP para consultar',
        style: TextStyle(color: cores.onSurfaceVariant),
      ),
    ],
  );

  Widget _formulario() => Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _cepController,
            enabled: !_carregando,
            keyboardType: TextInputType.number,
            inputFormatters: [_CepFormatter()],
            onSubmitted: (_) => _consultar(),
            decoration: InputDecoration(
              labelText: 'CEP',
              hintText: '00000-000',
              prefixIcon: const Icon(Icons.pin_drop_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: _carregando ? null : _consultar,
                  icon: const Icon(Icons.search),
                  label: const Text('Consultar', maxLines: 1, softWrap: false),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _carregando ? null : _limpar,
                  icon: const Icon(Icons.clear),
                  label: const Text('Limpar'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  Widget _resultado(ColorScheme cores) {
    if (_carregando) {
      return const Padding(
        key: ValueKey('carregando'),
        padding: EdgeInsets.all(32),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_mensagemErro != null) {
      return Card(
        key: const ValueKey('erro'),
        color: cores.errorContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: Icon(Icons.error_outline, color: cores.error),
          title: Text(
            _mensagemErro!,
            style: TextStyle(color: cores.onErrorContainer),
          ),
        ),
      );
    }

    if (_endereco != null) {
      final e = _endereco!;
      return Card(
        key: const ValueKey('dados'),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green.shade700),
                title: Text(
                  'Endereço encontrado',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
              ),
              const Divider(),
              _linha(Icons.markunread_mailbox_outlined, 'CEP', e.cep),
              _linha(Icons.markunread_mailbox_outlined, 'CEP', e.cep),
              _linha(Icons.signpost_outlined, 'Logradouro', e.logradouro),
              _linha(Icons.apartment, 'Unidade', e.unidade),
              _linha(Icons.holiday_village_outlined, 'Bairro', e.bairro),
              _linha(Icons.location_city, 'Cidade', e.localidade),
              _linha(Icons.map_outlined, 'UF', e.uf),
              _linha(Icons.flag_outlined, 'Estado', e.estado),
              _linha(Icons.public, 'Região', e.regiao),
              _linha(Icons.phone_outlined, 'DDD', e.ddd),
              _linha(Icons.numbers, 'IBGE', e.ibge),
              _linha(Icons.numbers, 'GIA', e.gia),
              _linha(Icons.numbers, 'SIAFI', e.siafi),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink(key: ValueKey('vazio'));
  }

  Widget _linha(IconData icone, String titulo, String valor) => ListTile(
    dense: true,
    leading: Icon(icone),
    title: Text(titulo, style: const TextStyle(fontSize: 12)),
    subtitle: Text(
      valor.isEmpty ? '—' : valor,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );
}
