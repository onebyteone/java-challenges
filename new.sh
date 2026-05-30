#!/usr/bin/env bash

set -e

# =========================
# Configuración
# =========================

PROJECT_NAME=$1
PACKAGE_NAME=${2:-com.example}

if [ -z "$PROJECT_NAME" ]; then
  echo "Uso:"
  echo "  ./new-java-project.sh <nombre-proyecto> [package]"
  echo ""
  echo "Ejemplo:"
  echo "  ./new-java-project.sh 01-hello-world com.example"
  exit 1
fi

# =========================
# Conversión package -> path
# =========================

PACKAGE_PATH=$(echo "$PACKAGE_NAME" | tr '.' '/')

# =========================
# Crear estructura
# =========================

mkdir -p "$PROJECT_NAME/build"
mkdir -p "$PROJECT_NAME/scripts"
mkdir -p "$PROJECT_NAME/src/main/java/$PACKAGE_PATH"

# =========================
# Main.java
# =========================

cat > "$PROJECT_NAME/src/main/java/$PACKAGE_PATH/Main.java" <<EOF
package $PACKAGE_NAME;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello from $PROJECT_NAME!");
    }
}
EOF

# =========================
# build.sh
# =========================

cat > "$PROJECT_NAME/scripts/build.sh" <<EOF
#!/usr/bin/env bash

set -e

ROOT_DIR=\$(cd "\$(dirname "\$0")/.." && pwd)

mkdir -p "\$ROOT_DIR/build"

javac -d "\$ROOT_DIR/build" \$(find "\$ROOT_DIR/src/main/java" -name "*.java")
EOF

# =========================
# run.sh
# =========================

cat > "$PROJECT_NAME/scripts/run.sh" <<EOF
#!/usr/bin/env bash

set -e

ROOT_DIR=\$(cd "\$(dirname "\$0")/.." && pwd)

java -cp "\$ROOT_DIR/build" $PACKAGE_NAME.Main
EOF

# =========================
# test.sh
# =========================
cat > "$PROJECT_NAME/scripts/test.sh" <<EOF
#!/usr/bin/env bash

set -e

ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)
TEST_CLASS=${1:-}

if [[ -z "$TEST_CLASS" ]]; then
  echo "Usage: $0 <TestClassName>"
  exit 1
fi

if [[ "$TEST_CLASS" == *.java ]]; then
  TEST_CLASS=${TEST_CLASS%.java}
fi

if [[ "$TEST_CLASS" != *.* ]]; then
  TEST_CLASS="com.example.${TEST_CLASS}"
fi

TEST_SOURCE="$ROOT_DIR/src/test/java/$(echo "$TEST_CLASS" | tr '.' '/')".java

if [[ ! -f "$TEST_SOURCE" ]]; then
  echo "Test source not found: $TEST_SOURCE"
  exit 1
fi

PROGRAM_CLASS=$(grep -E '^import com\.example\.programs\.[A-Za-z0-9_]+;' "$TEST_SOURCE" | head -n 1 | sed -E 's/^import (com\.example\.programs\.[A-Za-z0-9_]+);/\1/')

if [[ -z "$PROGRAM_CLASS" ]]; then
  echo "Could not infer program class from: $TEST_SOURCE"
  exit 1
fi

PROGRAM_SOURCE="$ROOT_DIR/src/main/java/$(echo "$PROGRAM_CLASS" | tr '.' '/')".java

if [[ ! -f "$PROGRAM_SOURCE" ]]; then
  echo "Program source not found: $PROGRAM_SOURCE"
  exit 1
fi

rm -rf "$ROOT_DIR/build/*"
mkdir -p "$ROOT_DIR/build"

javac -d "$ROOT_DIR/build" -sourcepath "$ROOT_DIR/src/main/java:$ROOT_DIR/src/test/java" "$PROGRAM_SOURCE" "$TEST_SOURCE"
java -cp "$ROOT_DIR/build" "$TEST_CLASS"
EOF

# =========================
# .gitignore
# =========================

cat > "$PROJECT_NAME/.gitignore" <<EOF
# Compiled class files
/build/
EOF

# =========================
# Permisos
# =========================

chmod +x "$PROJECT_NAME/scripts/build.sh"
chmod +x "$PROJECT_NAME/scripts/run.sh"
chmod +x "$PROJECT_NAME/scripts/test.sh"
echo "Proyecto '$PROJECT_NAME' creado correctamente."
