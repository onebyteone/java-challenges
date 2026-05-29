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
# Permisos
# =========================

chmod +x "$PROJECT_NAME/scripts/build.sh"
chmod +x "$PROJECT_NAME/scripts/run.sh"

echo "Proyecto '$PROJECT_NAME' creado correctamente."
