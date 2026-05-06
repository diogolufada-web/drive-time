library;

import 'dart:io';

import 'package:flutterflow_ai/flutterflow_ai.dart';

Future<void> main(List<String> args) async {
  final options = _parseCliOptions(args);
  try {
    await flutterFlowAI(
      buildStarterEditFlow,
      apiKey: options.apiKey,
      baseUrl: options.baseUrl,
      projectName: options.projectName,
      projectId: options.projectId,
      findOrCreate: options.findOrCreate,
      allowNewProject: options.allowNewProject,
      dryRun: options.dryRun,
      commitMessage: options.commitMessage,
    );
  } catch (error) {
    stderr.writeln('Error: ${formatFlutterFlowAIError(error)}');
    exit(1);
  }
}

final class _CliOptions {
  const _CliOptions({
    this.apiKey,
    this.baseUrl,
    this.projectName,
    this.projectId,
    this.findOrCreate = false,
    this.allowNewProject = false,
    this.dryRun = false,
    this.commitMessage,
  });

  final String? apiKey;
  final String? baseUrl;
  final String? projectName;
  final String? projectId;
  final bool findOrCreate;
  final bool allowNewProject;
  final bool dryRun;
  final String? commitMessage;
}

_CliOptions _parseCliOptions(List<String> args) {
  String? apiKey;
  String? baseUrl;
  String? projectName;
  String? projectId;
  String? commitMessage;
  var findOrCreate = false;
  var allowNewProject = false;
  var dryRun = false;

  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    switch (arg) {
      case '--help':
      case '-h':
        _printUsage();
        exit(0);
      case '--api-key':
        apiKey = _requireValue(args, ++i, '--api-key');
      case '--base-url':
        baseUrl = _requireValue(args, ++i, '--base-url');
      case '--project-name':
        projectName = _requireValue(args, ++i, '--project-name');
      case '--project-id':
        projectId = _requireValue(args, ++i, '--project-id');
      case '--commit-message':
        commitMessage = _requireValue(args, ++i, '--commit-message');
      case '--find-or-create':
        findOrCreate = true;
      case '--allow-new-project':
        allowNewProject = true;
      case '--dry-run':
        dryRun = true;
      default:
        stderr.writeln('Unknown option: $arg');
        _printUsage();
        exit(64);
    }
  }

  return _CliOptions(
    apiKey: apiKey,
    baseUrl: baseUrl,
    projectName: projectName,
    projectId: projectId,
    findOrCreate: findOrCreate,
    allowNewProject: allowNewProject,
    dryRun: dryRun,
    commitMessage: commitMessage,
  );
}

String _requireValue(List<String> args, int index, String flag) {
  if (index >= args.length) {
    stderr.writeln('Missing value for $flag.');
    _printUsage();
    exit(64);
  }
  return args[index];
}

void _printUsage() {
  stdout.writeln('''
Run the starter FlutterFlow AI edit flow.

Usage:
  dart run dsl/edit.dart [options]

Options:
  --api-key <key>           FlutterFlow API key. Defaults to FF_API_KEY.
  --base-url <url>          Override the FlutterFlow API base URL.
  --project-name <name>     Create a new project with this name.
  --project-id <id>         Push into an existing project by ID.
  --find-or-create          Retry by reusing a same-name project before creating.
  --allow-new-project       Bypass the workspace binding guard and create a different project.
  --commit-message <text>   Commit message for the push.
  --dry-run                 Compile and validate without pushing.
  --help, -h                Show this help.
''');
}

void buildStarterEditFlow(App app) {
  // Relatorios visual structure only. Keeps existing bottom navigation by
  // replacing only body[0], and updates only this page's app bar title.
  const goldAccent = 0xFFD4AF37;
  const pageBg = 0xFF0A0A0A;

  app.editPage('relatoriospage', (page) {
    page.ensureReplaced(
      page.findByType('AppBar'),
      AppBar(title: 'Relatórios'),
    );

    page.ensureReplaced(
      page.findByPath('relatoriospage.body[0]'),
      Container(
        name: 'RelatoriosBodyRoot',
        width: double.infinity,
        color: pageBg,
        child: Column(
          name: 'RelatoriosScrollColumn',
          scrollable: true,
          crossAxis: CrossAxis.stretch,
          spacing: 16,
          padding: 16,
          children: [
            Container(
              name: 'RelatoriosDateCard',
              width: double.infinity,
              padding: 16,
              color: Colors.primaryBackground,
              borderRadius: 16,
              borderColor: goldAccent,
              borderWidth: 1.5,
              child: Column(
                crossAxis: CrossAxis.stretch,
                spacing: 12,
                children: [
                  Text(
                    'Selecionar período',
                    style: Styles.titleSmall,
                    color: Colors.primaryText,
                  ),
                  Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: Button(
                          'Data início',
                          name: 'RelatoriosBtnStartDate',
                          width: double.infinity,
                          variant: ButtonVariant.outlined,
                          color: goldAccent,
                          textColor: goldAccent,
                          borderRadius: 12,
                          onTap: Snackbar('Calendário — em breve'),
                        ),
                      ),
                      Expanded(
                        child: Button(
                          'Aplicar',
                          name: 'RelatoriosBtnApplyDate',
                          width: double.infinity,
                          color: goldAccent,
                          textColor: pageBg,
                          borderRadius: 12,
                          onTap: Snackbar('Filtros — em breve'),
                        ),
                      ),
                      Expanded(
                        child: Button(
                          'Data fim',
                          name: 'RelatoriosBtnEndDate',
                          width: double.infinity,
                          variant: ButtonVariant.outlined,
                          color: goldAccent,
                          textColor: goldAccent,
                          borderRadius: 12,
                          onTap: Snackbar('Calendário — em breve'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              name: 'RelatoriosSummaryCard',
              width: double.infinity,
              padding: 16,
              color: Colors.primaryBackground,
              borderRadius: 16,
              borderColor: goldAccent,
              borderWidth: 1.5,
              child: Column(
                crossAxis: CrossAxis.stretch,
                spacing: 10,
                children: [
                  Text(
                    'Total Hoje',
                    style: Styles.titleSmall,
                    color: Colors.primaryText,
                  ),
                  Text(
                    '00:00:00',
                    style: Styles.headlineMedium,
                    color: goldAccent,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              name: 'RelatoriosListPlaceholderCard',
              width: double.infinity,
              padding: 16,
              color: Colors.primaryBackground,
              borderRadius: 16,
              borderColor: goldAccent,
              borderWidth: 1,
              child: Column(
                crossAxis: CrossAxis.stretch,
                spacing: 8,
                children: [
                  Text(
                    'Turnos no período',
                    style: Styles.titleSmall,
                    color: Colors.primaryText,
                  ),
                  Container(
                    padding: 12,
                    color: 0xFFF8F8F8,
                    borderRadius: 12,
                    child: Row(
                      mainAxisAlignment: MainAxis.spaceBetween,
                      children: [
                        Text(
                          'Turno 01',
                          style: Styles.bodyMedium,
                          color: Colors.primaryText,
                        ),
                        Text(
                          '00:00 - 00:00',
                          style: Styles.bodySmall,
                          color: Colors.secondaryText,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: 12,
                    color: 0xFFF8F8F8,
                    borderRadius: 12,
                    child: Row(
                      mainAxisAlignment: MainAxis.spaceBetween,
                      children: [
                        Text(
                          'Turno 02',
                          style: Styles.bodyMedium,
                          color: Colors.primaryText,
                        ),
                        Text(
                          '00:00 - 00:00',
                          style: Styles.bodySmall,
                          color: Colors.secondaryText,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Placeholder visual - sem dados reais ainda',
                    style: Styles.bodySmall,
                    color: Colors.secondaryText,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Button(
              'Exportar PDF',
              name: 'RelatoriosBtnExportPdf',
              width: double.infinity,
              color: goldAccent,
              textColor: pageBg,
              borderRadius: 14,
              padding: EdgeInsets.symmetric(vertical: 14),
              icon: 'picture_as_pdf',
              onTap: Snackbar('Exportação PDF — em breve'),
            ),
          ],
        ),
      ),
    );
  });
}
