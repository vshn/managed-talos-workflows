import sys

if len(sys.argv) < 3:
    print(f"Usage: {sys.argv[0]} <current version> <target version>")
    sys.exit(2)

current_version = tuple(map(int, sys.argv[1].split(".")))
target_version = tuple(map(int, sys.argv[2].split(".")))

if current_version > target_version:
    print("❌ Downgrades aren't supported.")
    print(f"   Current version: {sys.argv[1]}")
    print(f"   Target version: {sys.argv[2]}")
    sys.exit(1)


if target_version[1] - current_version[1] > 1:
    print("❌ Skipping minor versions isn't supported")
    print(f"   Current version: {sys.argv[1]}")
    print(f"   Target version: {sys.argv[2]}")
    sys.exit(1)

print(f"✅ Upgrade from {sys.argv[1]} to {sys.argv[2]} is supported")
