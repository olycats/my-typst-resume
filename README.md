# my-typst-resume

My personal resume builder powered by Typst.  

## Project Structure

```sh
my-typst-resume
├─ data/ # YAML files containing resume data
├─ fonts/ # Font Awesome .otf files
├─ modules/ # Shared .typ modules for reuse
├─ outputs/ # .typ files to be compiled into PDFs
├─ pdf/ # Generated PDF files
└─ build.sh # Shell script to compile .typ files into PDFs
```

## Shell Script Usage

The `build.sh` script automates the compilation of all `.typ` files in the `outputs/` directory.  
Compiled PDFs are saved in the `pdf/` directory.

### Steps
1. Make the script executable: `chmod +x build.sh`
2. Run the script: `./build.sh`. 