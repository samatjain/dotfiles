function splunk() {
	# Try to find the `splunk` binary based on `$SPLUNK_HOME`.

	# If $SPLUNK_HOME is set, use it, otherwise use /opt/splunk
	local _SPLUNK_HOME=${SPLUNK_HOME-/opt/splunk}
	if [[ ! -x ${_SPLUNK_HOME}/bin/splunk ]]; then
		echo "\$SPLUNK_HOME is not set or \$SPLUNK_HOME/bin/splunk ($_SPLUNK_HOME/bin/splunk) is not executable"
		return 1
	fi
	${_SPLUNK_HOME}/bin/splunk "$@"
}
