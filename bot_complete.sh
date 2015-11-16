#/bin/sh
echo "Botlane completing..."
PATH="$PATH:/usr/local/bin"
cd "${XCS_SOURCE_DIR}/${PROJECT_ROOT}"
fastlane bot_complete
FASTLANE_STATUS=$?
echo "Botlane complete."
exit $FASTLANE_STATUS
