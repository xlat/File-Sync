/* File::Sync.xs
 *
 * Copyright ɠ1996,1997 Carey Evans.  All rights reserved.  This module is
 * free software; you can redistribute it and/or modify it under the same
 * terms as Perl itself. */

#ifdef __cplusplus
extern "C" {
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#ifdef __cplusplus
}
#endif

#include <unistd.h>

//TODO: detect windows system, or link with a cygwin dll and try to call sync/fsync
#ifndef HAVE_SYNC_N_FSYNC
int fsync(int fd){
	return 0;
}

int sync()
{
    return 0;
}
#endif

#ifndef HAVE_SYNC
int sync()
{
    return 0;
}
#endif

#ifndef HAVE_FDATASYNC
int fdatasync(int fh)
{
    croak("skipping unsupported fdatasync() call - you might want to use fsync() instead");
    return 0;
}
#endif

MODULE = File::Sync		PACKAGE = File::Sync

PROTOTYPES:	ENABLE

void
sync()
    PROTOTYPE:	

SV*
fsync_fd(fd)
	int		fd
    PROTOTYPE:		$
    CODE:
	if (fsync(fd) == -1) XSRETURN_UNDEF;
	else XSRETURN_YES;

SV*
fdatasync_fd(fd)
	int		fd
    PROTOTYPE:		$
    CODE:
	if (fdatasync(fd) == -1) XSRETURN_UNDEF;
	else XSRETURN_YES;
