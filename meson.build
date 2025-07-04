project(
    'keyboard',
    'vala', 'c',
    version: '2.4.2',
    meson_version: '>= 0.58.0'
)

i18n = import('i18n')
gnome = import('gnome')
gettext_name = 'io.elementary.panel.' + meson.project_name()

prefix = get_option('prefix')
libdir = prefix / get_option('libdir')

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(gettext_name), language:'c')
add_project_arguments('-DG_LOG_DOMAIN="@0@"'.format(gettext_name), language:'c')

gresource = gnome.compile_resources(
    'gresource',
    'data' / 'keyboard.gresource.xml',
    source_dir: 'data'
)

xkbconf = dependency('xkeyboard-config')
xkb_base = xkbconf.get_variable('xkb_base')

conf_data = configuration_data()
conf_data.set('XKB_BASE', xkb_base)
conf_data.set('LOCALEDIR', prefix / get_option('localedir'))
conf_data.set('GETTEXT_PACKAGE', gettext_name)
config_file = configure_file (
    input: 'src/Config.vala.in',
    output: 'Config.vala',
    configuration: conf_data
)

wingpanel_dep = dependency('wingpanel-8')
wingpanel_indicatorsdir = wingpanel_dep.get_variable('indicatorsdir', pkgconfig_define: ['libdir', libdir])


ibus_dep = dependency('ibus-1.0')
if(ibus_dep.version().version_compare('>=1.5.19'))
    add_project_arguments(['--define', 'IBUS_1_5_19'], language: 'vala')
endif

shared_module(
    meson.project_name(),
    gresource,
    'src/Indicator.vala',
    'src/LayoutButton.vala',
    'src/PopoverWidget.vala',
    config_file,
    dependencies: [
        dependency('glib-2.0'),
        dependency('gobject-2.0'),
        dependency('granite-7', version: '>= 7.6.0'),
        dependency('gtk4'),
        dependency('libxml-2.0'),
        wingpanel_dep,
        ibus_dep,
    ],
    install: true,
    install_dir : wingpanel_indicatorsdir
)

subdir('po')
subdir('data')

gnome.post_install(
    glib_compile_schemas: true
)
