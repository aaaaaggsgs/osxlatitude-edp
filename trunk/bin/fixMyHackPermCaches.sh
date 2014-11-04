echo "<b>Trying to fix kexts permissions and rebuild caches...</b>"

echo "<br>Copying myHack kext..."
rm -rf /System/Library/Extensions/myHack.kext
cp -rf /Extra/EDP/myHack.kext /System/Library/Extensions

echo "<br>Integrating kexts inide myHack kext..."
cp -a /Extra/Extensions/. /System/Library/Extensions/myHack.kext/Contents/PlugIns/
cp -a /Extra/Extensions/*.kext/Contents/PlugIns/. /System/Library/Extensions/myHack.kext/Contents/PlugIns/
rm -rf /System/Library/Extensions/myHack.kext/Contents/PlugIns/*.kext/Contents/PlugIns

echo "<br>Fixing permissions..."
chmod -R 755 /System/Library/Extensions/myHack.kext
chmod -R 755 /System/Library/Extensions/myHack.kext/Contents/PlugIns/*.kext

chown -R root:wheel /System/Library/Extensions/myHack.kext
chown -R root:wheel /System/Library/Extensions/myHack.kext/Contents/PlugIns/*.kext

sudo touch /System/Library/Extensions

echo "<br>Rebuilding caches..."
kextcache -prelinked-kernel /System/Library/Caches/com.apple.kext.caches/Startup/kernelcache -K /System/Library/Kernels/kernel /System/Library/Extensions

echo "<br><b>Fixing permissions and rebuilding caches are finished.</b>"
