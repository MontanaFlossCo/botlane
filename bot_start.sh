#/bin/sh
echo "Botlane starting..."
PATH="$PATH:/usr/local/bin"
cd "${XCS_SOURCE_DIR}/${PROJECT_ROOT}"
fastlane bot_start
