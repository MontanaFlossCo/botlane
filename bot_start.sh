#/bin/sh
echo "Botlane starting..."
PATH="$PATH:/usr/local/bin"
cd "${XCS_SOURCE_DIR}/${PROJECT_ROOT}"

# TODO: Emit a friendly error and exit status if fastlane not found or Fastfile missing 
fastlane bot_start
