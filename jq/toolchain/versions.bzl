"""https://github.com/jqlang/jq/releases

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
    },
}
