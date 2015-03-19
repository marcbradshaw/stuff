#!/usr/bin/perl

my $user = $ENV{'USER'};

my $has_locallib = 1;
my $has_cpanm    = 1;

eval { 
    require local::lib;
};
if ( $@ ) {
    print "local::lib is not installed\n";
    $has_locallib = 0; 
}

eval { 
    require App::cpanminus;
};
if ( $@ ) {
    print "cpamninus is not installed\n";
    $has_cpanm = 0; 
}

if ( ! $has_locallib ) {
    if ( $user eq 'root' ) {
        if ( $has_cpanm ) {
            system 'cpanm local::lib';
        }
        else {
            system 'cpan local::lib';
        }
        print "local::lib installed, please setup and retry\n";
        exit 0;
    }
    else {
        print "Please install local::lib as root and then retry\n";
        exit 0;
    }
}

if ( ! $has_cpanm ) {
    if ( $user eq 'root' ) {
        system 'cpan App::cpanminus';
    }
    else {
        print "Please install cpanminus as root, then retry\n";
        exit 0;
    }
}

my @modules = qw{
    App::cpanoutdated App::cpanlistchanges App::Ack
};
my @install_modules;

foreach my $module ( @modules ) {
    eval 'require ' . $module;
    if ( $@ ) {
        push @install_modules, $module;
    }
}

if ( @install_modules ) {
    my $cmd = 'cpanm ' . join( q{ }, @install_modules );
    print "Installing with $cmd\n";
    system( $cmd );
}
else {
    print "All modules installed\n";
}
