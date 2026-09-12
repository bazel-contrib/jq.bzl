"""https://github.com/stedolan/jq/releases

The integrity hashes can be computed with
shasum -b -a 384 [downloaded file] | awk '{ print $1 }' | xxd -r -p | base64
"""
JQ_VERSIONS = {
    "1.8.2": {
        "linux-amd64": "sha384-THcFEVKSAQoeKYKNLpHotOsHpVElzghHC1Yl1dAUDSzn2aCKyTJuY9LjBTLl0v28",
        "linux-arm64": "sha384-dVEFiMskmbPJB7Qeyzhh+teMzOxRSK3GChmkzWSq7HgoeWCIbRdcO4H8u6g7aSbF",
        "linux-riscv64": "sha384-N6uq6S57QhUnSeEq3OtA2jcUndx1GHQjlsfSvzyXOnLjIV/yiGDH4JtblJ8tyG8x",
        "macos-amd64": "sha384-LNcX+wzOt3/KaZi5JxNoJz2FKNHlupM9WN1FzDc+PUbbEsG0hPzH6JBCK6oxl70w",
        "macos-arm64": "sha384-v5dCjZI/RAgEhhAURV+HdHV7G0sajQoS6zXxa9itJPPk8kX8GbUxgA97mvcUq24R",
        "win64": "sha384-H+uQQ+llHv00+Nu7ehjTu83rAq9rmMx6uu28lpp9h5JXWjlz6KcQaAR473uv5VUR",
        "windows-arm64": "sha384-TEIk+nrBHuiv/XnM30uU+e1QEuuAH18+eKbMKZ/bKQ5fMxBvaTp9EMmeAErl/7Od",
    },
    "1.7": {
        "linux-amd64": "sha384-4wJ15NoxFf7r1Zf5YVGUeMPx/pfWlSfMJWLFcu4fUcBFe5L4BOpF/njEK8AH58od",
        "linux-arm64": "sha384-y9BwX+RyXf2a16xwtvcjHFfIBp3K3Ukyg4GjtmxBtynD/BKNf+0tuLtZx64TTI+/",
        "linux-riscv64": "sha384-mU7uq/gjpj7pDl9rqM1bcPvyqfi/+yfqnb1Jdp26bzQ5oXvZDn39eeJ8hla2nUaV",
        "macos-amd64": "sha384-N0WdpiD8zl1k9888yGxWW/dHzztOTU+RTlZrzOYJMXXUUMqjnqXq8GwnHDsC9Lk3",
        "macos-arm64": "sha384-0nnKlrEAU7NCzTM63XYkhAGGapA/IT2O2jkU+H+ZbQFu3E+XEbgw5E/+o0oHjLGf",
        "win64": "sha384-2QfBgUpi1I5KPVrKtZnPcur+Wn/iE+tZVPFKXiIPoBKTpqZKhzc/CdqjcBn+IPiy",
    },
}
