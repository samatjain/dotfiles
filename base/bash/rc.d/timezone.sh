# Debian/Ubuntu systems
export TZ=${TZ:-":$(timedatectl show --property=Timezone --value)"}
