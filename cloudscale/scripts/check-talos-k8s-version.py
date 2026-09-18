import sys

if len(sys.argv) < 4:
    print(
        f"Usage: {sys.argv[0]} <talos support matrix>.md <target k8s minor> <target talos minor>"
    )
    sys.exit(2)

data = ""
with open(sys.argv[1], "r", encoding="utf-8") as f:
    while len(data) == 0:
        line = f.readline()
        if "Kubernetes" in line:
            data = line
supported_versions = data.split("| ")[2].strip()

target_version = sys.argv[2]
talos_version = sys.argv[3]

if target_version in supported_versions.split(", "):
    print(f"✅ Talos v{talos_version} supports Kubernetes {target_version}")
    sys.exit(0)
else:
    print(
        f"❌ Target Kubernetes version {target_version} isn't supported by Talos v{talos_version}."
    )
    print(f"   Supported Kubernetes versions are {supported_versions}.")
    sys.exit(1)
