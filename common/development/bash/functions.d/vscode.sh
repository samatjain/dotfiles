#!/bin/sh

# zsh compatible
vscode-server-cleanup() {
	kill -9 `ps ax | grep "remoteExtensionHostAgent.js" | grep -v grep | awk '{print $1}'`
	kill -9 `ps ax | grep "watcherService" | grep -v grep | awk '{print $1}'`
	rm -rf ~/.vscode-server # Or ~/.vscode-server-insiders
}
