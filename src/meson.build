conf_data = configuration_data()
conf_data.set('DATADIR', get_option('datadir'))
conf_data.set('PKGDATADIR', get_option('datadir') + '/' + meson.project_name())
conf_data.set('TERMINAL_NAME', 'repo')
conf_data.set('EXEC_NAME', meson.project_name())
conf_data.set('GETTEXT_PACKAGE', meson.project_name())
conf_data.set('RELEASE_NAME', 'Repo')
conf_data.set('VERSION', '0.0.1')
conf_data.set('VERSION_INFO', 'Alpha')
conf_data.set('PREFIX', get_option('prefix'))
configure_file(
    input: 'config.vala.in',
    output: 'config.vala',
    configuration: conf_data
)
