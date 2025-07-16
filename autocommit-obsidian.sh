#!/bin/bash

set -euo pipefail

DIRETORIO_OBSIDIAN=/home/aml/Documentos/obsidian

if find "$DIRETORIO_OBSIDIAN" -type f -newermt "$(date +%Y-%m-%d)" ! -name "*.log" | grep -q .
	then
		echo "[INFO] Alteracoes detectadas em '$DIRETORIO_OBSIDIAN'."
		cd $DIRETORIO_OBSIDIAN || exit 1

		echo "[INFO] Iniciando processo de commit..."

		echo "[INFO] Os seguintes arquivos serao adicionados no stage:"
		git status

		echo "[INFO] Adicionando arquivos ao stage..."
		git add .

		_DATA_COMMIT=$(date +%Y-%m-%d)

		echo "[INFO] Relizando commit..."
		git commit -m "$_DATA_COMMIT" || {
			echo "[WARN] Nada para commitar."
			exit 0
		}

		echo "[INFO] Realizando push para o repositorio remoto..."
		git push
		
		echo "[INFO] Processo concluído com sucesso"
	else

		echo "[INFO] Nenhuma alteracao foi encontrada"

fi
