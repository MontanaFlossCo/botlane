# botlane
Funnest ever scripts and actions to make use of fastlane and Xcode Bots.

These scripts make it easy to use `fastlane` within Xcode Bots to update your dependencies and report build status.

## Step 1 — set up Botlane in your project:

First, clone the Botlane scripts repository into your project.

`git submodule add https://github.com/MontanaFlossCo/botlane.git`

## Step 2 — edit your Fastlane configuration to use Botlane 

Edit your `fastlane/Fastfile` and add `import "../botlane/Botfile"` to each platform block, or to global scope if you don't have per-platform lane configurations.

Example:

```
platform :ios do

  # Add this to your Fastfile to import the Botlane lanes and actions
  import "../botlane/Botfile"

  ...   
```

Now you should be able to run `fastlane bot_start` locally and check that works with no errors.

## Step 3 — Setup your Xcode Bots to use Botlane trigger scripts

Edit/create your Bot and in the Triggers tab add a **Run Script** that tells the script what your project's root directory name is, and calls the start script that will update your dependencies before Xcode runs your builds.

**Before trigger script**
```
export PROJECT_ROOT="YourCoolAppProjectDirectoryName"
. ${PROJECT_ROOT}/botlane/bot_start.sh
```

**After trigger script**
```
export PROJECT_ROOT="YourCoolAppProjectDirectoryName"
. ${PROJECT_ROOT}/botlane/bot_complete.sh
```

