# botlane
Funnest ever scripts and actions to make use of fastlane and Xcode Bots.

These scripts make it easy to use `fastlane` within Xcode Bots to update your dependencies and report build status.

## Step 1 — set up Botlane in your project:

First, clone the Botlane scripts repository into your project.


```
git clone --depth=1 https://github.com/MontanaFlossCo/botlane.git
rm -Rf botlane/.git
```
_NOTE: in future we'll use a github release zip for this_

We clone the repository into your code base so that you can conmit the scripts to git yourself as part of your project. Use of submodules requires more Xcode Bot shenanigans and... you don't really want your CI server to be downloading code from some public repository you don't control do you? The correct answer is **NO**.

We remove the nested `.git` so you don't get problems with it looking like a submodule.

To update your version of botlane in future, simply `rm -Rf botlane` and clone it again as above.

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

