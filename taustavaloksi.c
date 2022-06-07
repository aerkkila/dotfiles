#include <errno.h>
#include <string.h>
#include <stdio.h>

const char* kirjoit_tied = "/sys/class/backlight/amdgpu_bl0/brightness";
const char* luett_tied   = "/sys/class/backlight/amdgpu_bl0/max_brightness";
const int max_syote = 100;

int main(int argc, char** argv) {
  int maks=255, laitto=max_syote;
  FILE* f = fopen(luett_tied, "r");
  if(f)
    fscanf(f, "%d", &maks);
  fclose(f);
  if(argc>1)
    sscanf(argv[1], "%d", &laitto);
  float kerr = (float)maks/max_syote;
  if(!(f = fopen(kirjoit_tied, "w"))) {
    fprintf(stderr, "fopen \"%s\": %s\n", kirjoit_tied, strerror(errno));
    return 1;
  }
  fprintf(f, "%.0f", laitto*kerr);
  fclose(f);
  return 0;
}
