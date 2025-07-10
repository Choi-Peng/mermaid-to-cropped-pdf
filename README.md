# Mermaid to Cropped PDF Workflow (macOS)

Convert [Mermaid](https://mermaid.js.org/) diagrams into tightly-cropped PDF files using `mmdc` (Mermaid CLI) and `pdfcrop` on **macOS**.

## Example Output
Example Mermaid diagram:

<pre>
flowchart TD
    A[Christmas] -->|Get money| B(Go shopping)
    B --> C{Let me think}
    C -->|One| D[Laptop]
    C -->|Two| E[iPhone]
    C -->|Three| F[fa:fa-car Car]
</pre>

Example cropped output: [example-cropped.pdf](example-cropped.pdf)

Example un-cropped output: [example.pdf](example.pdf) (default A4 size)

## Requirements

Before installing, ensure you have [Node.js](https://nodejs.org/) and [Homebrew](https://brew.sh/) installed.

### Install Mermaid CLI

```bash
npm install -g @mermaid-js/mermaid-cli
```

### Install BasicTeX and Ghostscript

```bash
brew install basictex ghostscript
```

Then add TeX binaries to your shell config:

```bash
echo 'export PATH="/Library/TeX/texbin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Install pdfcrop

```bash
sudo tlmgr install pdfcrop
```

## Usage
This section describes how to manually convert and crop a Mermaid diagram. For automation, see the [Automation](#automation) section.

1. Create a Mermaid diagram in a `.mmd` file, e.g. `example.mmd`
2. Convert .mmd to PDF (default A4 size)
    ```bash
    mmdc -i example.mmd -o example.pdf
    ```
3. Crop the PDF
    ```bash
    pdfcrop example.pdf example-cropped.pdf
    ```
    The `example-cropped.pdf` will now be tightly fitted to your diagram size.

## Automation

You can automate the process using the [`convert.sh`](convert.sh) script.

First make the script executable:
```bash
chmod +x convert.sh
```

Then run the script:
```bash
./convert.sh <input.mmd> [OPTIONS]
```

### Options

- `-k, --keep`: Keep the intermediate (uncropped) PDF
- `-d, --delete`: Delete the intermediate PDF after cropping (default)
- `-h, --help`: Show this help message


### Example
```bash
./convert.sh example.mmd -k
```

This will keep the intermediate PDF file `example.pdf` and output the cropped PDF to `example-cropped.pdf`.
