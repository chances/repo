# project name and programming language
project('com.github.chances.repo', 'vala', 'c')

# Include the translations module
i18n = import('i18n')

# Include the gnome module
gnome = import('gnome')
asresources = gnome.compile_resources(
    'as-resources', 'data/assets.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

# Set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')

subdir('src')
executable(
    meson.project_name(),
    'src/Main.vala',
    'src/Application.vala',
    'src/MainWindow.vala',
    'src/config.vala',
    'src/Services/Settings.vala',
    'src/Services/Repositories.vala',
    'src/Widgets/HeaderBar.vala',
    dependencies: [
        dependency('glib-2.0'),
        dependency('gobject-2.0'),
        dependency('gtk+-3.0'),
        dependency('granite'),
        dependency('gee-0.8'),
    ],
    install: true
)

meson.add_install_script('meson/post_install.py')
subdir('data')
subdir('po')
subdir('schemas')
