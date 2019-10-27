#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

int main (void){
    struct stat stat_buf;
    stat("../test.asm", &stat_buf);
    printf("%ld\n", sizeof stat_buf.st_dev);
    printf("%ld\n", sizeof stat_buf.st_ino);
    printf("%ld\n", sizeof stat_buf.st_mode);
    printf("%ld\n", sizeof stat_buf.st_nlink);
    printf("%ld\n", sizeof stat_buf.st_uid);
    printf("%ld\n", sizeof stat_buf.st_gid);
    printf("%ld\n", sizeof stat_buf.st_rdev);
    printf("%ld\n", sizeof stat_buf.st_size);
    printf("%ld\n", sizeof stat_buf.st_blksize);
    printf("%ld\n", sizeof stat_buf.st_blocks);
    printf("%ld\n", sizeof stat_buf.st_atime);
    printf("%ld\n", sizeof stat_buf.st_mtime);
    printf("%ld\n", sizeof stat_buf.st_ctime);
    printf("%ld\n", stat_buf.st_size);
}