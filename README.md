# Med Tracker

Med Tracker is a personal dose log from UnityForge Labs. It runs in the browser and can be added to your home screen. You log a dose, see a double-dose lock, a supply runway, read-aloud, a JSON backup, and colour themes.

This is not medical advice, and it does not replace your doctor or your own judgement.

Your dose log and settings stay in this browser, on your device. There is no account, and UnityForge does not receive your dose history. You can export a backup file you keep. Clearing browser data, or using a different browser or device, will start you with an empty log unless you import that backup. The web preview does load fonts and scripts from outside services for look and feel. The app does not send your dose log to those services.

## Open the app

Host this folder on any static web server over HTTPS, then open it in Chrome or Safari. The first open needs a network connection so the page can load. After that, the home-screen icon can open the saved copy.

See [GUIDE.md](GUIDE.md) for install and everyday use. The buyer terms are in [LICENCE.md](LICENCE.md). The same medical line and privacy wording are in [DISCLAIMER.md](DISCLAIMER.md).

These notices are in this pack. They are not on the live preview until Jess says yes.

## Shop zip

From this folder:

```bash
bash scripts/build-shop-zip.sh
```

That writes `dist/med-tracker-shop.zip` with the app, icons, manifest, licence, disclaimer, and guide. It packs an allow-list only, so git history and secrets stay out.

## Reset log

Branch `fix/reset-last-dose-log` (commit `36ab829`) adds a confirmed Reset log. It is waiting on Jess. It is not in this pack and it is not merged to `main`. After a yes, cherry-pick that commit onto this branch and keep both the reset dialog and these shop-pack edits. Expect overlap in `index.html` around the safety card, the Escape key handler, and the read-aloud scripts.
