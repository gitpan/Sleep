use Module::Build;
my $build = Module::Build->new
(
    module_name => 'Sleep',
    license     => 'perl',
    requires    => {
        'JSON::XS'   => 0,
        Carp         => 0,
        'DBIx::DWIW' => '0.48',
    },
);
$build->create_build_script;
