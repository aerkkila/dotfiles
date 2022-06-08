#include <errno.h>
#include <string.h>
#include <stdio.h>

const char* kirjoit_tied = "/sys/class/backlight/amdgpu_bl0/brightness";
const char* luett_tied   = "/sys/class/backlight/amdgpu_bl0/max_brightness";
const int max_syote = 100;

int main(int argc, char** argv) {
  int maks=0, laitto=max_syote, suunta=0;
  FILE* f = fopen(luett_tied, "r");
  if(!f)
    return 1;
  fscanf(f, "%d", &maks);
  fclose(f);
  if(argc>1) {
    if(*argv[1] == '-')
      suunta = -1;
    else if(*argv[1] == '+')
      suunta = 1;
    sscanf(argv[1]+!!(suunta), "%d", &laitto);
  }
  float kerr = (float)maks/max_syote;
  if(suunta) {
    if(!(f = fopen(kirjoit_tied, "r"))) {
      fprintf(stderr, "fopen \"%s\": %s\n", kirjoit_tied, strerror(errno));
      return 1;
    }
    int arvo;
    if(fscanf(f, "%d", &arvo)!=1) {
      fclose(f);
      return 2;
    }
    arvo /= kerr;
    laitto = arvo + suunta*laitto;
    fclose(f);
  }
  if(laitto < 0)
    laitto = 0;
  else if(laitto > max_syote)
    laitto = max_syote;
  if(!(f = fopen(kirjoit_tied, "w"))) {
    fprintf(stderr, "fopen \"%s\": %s\n", kirjoit_tied, strerror(errno));
    return 3;
  }
  fprintf(f, "%.0f", laitto*kerr);
  fclose(f);
  return 0;
}
