use ExtUtils::MakeMaker;

sub chk_define () {
  # Work out -D... for Sync.o.

  # Apparently, OS/2 doesn't implement sync().
  if (defined $ExtUtils::MakeMaker::Is_OS2 and $ExtUtils::MakeMaker::Is_OS2) {
    warn "OS/2 doesn't implement sync() - making it a no-op.\n";
    return '';
  }

  return '-DHAVE_SYNC';
}

WriteMakefile(
  'NAME'	=> 'File::Sync',
  'VERSION_FROM' => 'Sync.pm', # finds $VERSION

  'DEFINE'	=> chk_define(),

  'dist'	=> { COMPRESS => 'gzip -9', SUFFIX => 'gz' },
);
