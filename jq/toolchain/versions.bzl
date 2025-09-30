"""https://github.com/stedolan/jq/releases

The integrity hashes can be computed with
shasum -b -a 384 [downloaded file] | awk '{ print $1 }' | xxd -r -p | base64
"""
JQ_VERSIONS = {
    "1.7": {
        "linux-amd64": "sha384-4wJ15NoxFf7r1Zf5YVGUeMPx/pfWlSfMJWLFcu4fUcBFe5L4BOpF/njEK8AH58od",
        "linux-arm64": "sha384-y9BwX+RyXf2a16xwtvcjHFfIBp3K3Ukyg4GjtmxBtynD/BKNf+0tuLtZx64TTI+/",
        "macos-amd64": "sha384-N0WdpiD8zl1k9888yGxWW/dHzztOTU+RTlZrzOYJMXXUUMqjnqXq8GwnHDsC9Lk3",
        "macos-arm64": "sha384-0nnKlrEAU7NCzTM63XYkhAGGapA/IT2O2jkU+H+ZbQFu3E+XEbgw5E/+o0oHjLGf",
        "win64": "sha384-2QfBgUpi1I5KPVrKtZnPcur+Wn/iE+tZVPFKXiIPoBKTpqZKhzc/CdqjcBn+IPiy",
    },
}
