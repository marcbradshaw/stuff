#!/usr/bin/perl

use strict;
use warnings;
use Carp;
use Cwd;
use Term::ReadKey;

main();

sub main {
    # TODO Check for git

    my $root = get_git_root();

    # TODO allow user to specify repo and spec on command line

    my $repo = 'origin';
    my $spec = q{}; # 'master';

    git_status();
    git_fetch({
        'repo' => $repo,
        'spec' => $spec,
    });
    if ( ask( 'Show logs?' ) ) {
        git_log({
            'repo' => $repo,
            'spec' => $spec,
        });
    }
    if ( ask( 'Show Diff?' ) ) {
        git_diff({
            'repo' => $repo,
            'spec' => $spec,
        });
    }
    if ( ask( 'Merge Changes?' ) ) {
        git_merge({
            'repo' => $repo,
            'spec' => $spec,
        });
    }
    return;
}

sub git_get_branch {
    my $branch = `git branch | grep '^\*' | cut -b3-`;
    return $branch;
}

sub get_git_root {

    # Change to and return the current working tree root
    # or croak if we are in in a git tree

    my $root = `git rev-parse --show-cdup`;
    chomp( $root );

    if ( $root eq '' ) {
        # We didn't get a result, either we are already at root, or not in a repo at all
        $root = `git rev-parse --show-cdup 2>&1`;
        chomp( $root );
        if ( $root ne '' ) {
            die;
        }
        # Current dir is just fine
    }
    elsif ( -d $root ) {
        # Looks good
        chdir( $root );
    }

    print 'Working in ' . cwd() . "\n";
    return cwd();
}


sub git_status {
    header( 'LOCAL STATUS');
    cmd( 'git status' );
    footer();
    return;
}

sub git_fetch {
    my ( $args ) = @_;
    my $repo = $args->{'repo'};
    my $spec = $args->{'spec'};
    header( 'FETCH' );
    cmd( 'git fetch ' . $repo . q{ } . $spec );
    footer();
    return;
}

sub remote {
    my ( $args ) = @_;
    my $repo = $args->{'repo'};
    my $spec = $args->{'spec'};
    my $remote = $repo;
    if ( $spec ) {
        $remote .= '/' . $spec;
    }
    return $remote;
}

sub git_log {
    my ( $args ) = @_;
    my $repo = $args->{'repo'};
    my $spec = $args->{'spec'};
    header( 'LOGS SINCE LAST UPDATE' );
    cmd( 'git log HEAD..' . remote( $args ) );
    footer();
    return;
}

sub git_diff {
    my ( $args ) = @_;
    my $repo = $args->{'repo'};
    my $spec = $args->{'spec'};
    header( 'DIFF SINCE LAST UPDATE' );
    cmd( 'git diff HEAD..' . remote( $args ) );
    footer();
    return;
}

sub git_merge {
    my ( $args ) = @_;
    my $repo = $args->{'repo'};
    my $spec = $args->{'spec'};
    header( 'MERGE CHANGE SET' );
    cmd( 'git merge ' . remote( $args ) );
    footer();
    return;
}

sub ask {
    my ( $question ) = @_;
    print "\n$question [Y/n]\n";
    ReadMode 4;
    my $answer;
    while (not defined ( $answer = ReadKey( -1 ) ) ) {
        sleep 1;
    }
    ReadMode 0;
    chomp( $answer );
    if ( $answer eq q{} || lc $answer eq 'y' ) {
        return 1;
    }
    return 0;
}

sub cmd {
    my ( $cmd ) = @_;
    system $cmd;
    return;
}

sub header {
    my ( $title ) = @_;
    print "**** $title ****\n";
    return;
}

sub footer {
    print "\n";
    return;
}

