#!/usr/bin/env bash

set -euo pipefail

# === CONFIG ===
DRY_RUN=false   # mude para false para realmente deletar

# === ENCONTRAR ROOT DO GIT ===
if ! git_root=$(git rev-parse --show-toplevel 2>/dev/null); then
    echo "Erro: este diretório não está dentro de um repositório Git."
    exit 1
fi

echo "Git root encontrado em: $git_root"

cd "$git_root"

# === PADRÕES ===
patterns=(
    "reports/genus/.[1-9]*"
)

# === BUSCA E REMOÇÃO ===
files_found=()

for pattern in "${patterns[@]}"; do
    while IFS= read -r -d '' file; do
        files_found+=("$file")
    done < <(find . -path "./$pattern" -type f -print0 2>/dev/null)
done

# === RESULTADO ===
if [ ${#files_found[@]} -eq 0 ]; then
    echo "Nenhum arquivo indesejado encontrado."
    exit 0
fi

echo "Arquivos encontrados:"
for f in "${files_found[@]}"; do
    echo "$f"
done

# === EXECUÇÃO ===
if [ "$DRY_RUN" = true ]; then
    echo
    echo "[DRY RUN] Nenhum arquivo foi removido."
    echo "Para remover, altere DRY_RUN=false no script."
else
    echo
    echo "Removendo arquivos..."
    for f in "${files_found[@]}"; do
        rm -f "$f"
    done
    echo "Remoção concluída."
fi