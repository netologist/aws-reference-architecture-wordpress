#!/usr/bin/env bash
NAME=talisman.sh
VERSION=1.1.0
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TALISMAN_REPORT_VERSION="${TALISMAN_REPORT_VERSION:-1.4}"
TALISMAN_INSTALL_SCRIPT="$HOME/install-talisman.sh"
TALISMAN_HTML_REPORT="$HOME/.talisman/talisman_html_report"

check_deps() {
  if [ -f "$TALISMAN_INSTALL_SCRIPT" ]; then
    echo "âœ… install-talisman.sh already installed"
  else
    echo "âš¡ï¸ install-talisman.sh installing"
    install_script
  fi

  if [ -d "$TALISMAN_HTML_REPORT" ]; then
    echo "âœ… talisman_html_report already installed"
  else
    echo "âš¡ï¸ talisman_html_report installing"
    install_report
  fi

  if [ -f $SCRIPT_DIR/.git/hooks/bin/talisman ]; then
    echo "âœ… talisman already installed"
  else
    echo "âš¡ï¸ talisman installing"
    install_hooks
  fi

  echo ""
}

talisman_report() {
  $SCRIPT_DIR/.git/hooks/bin/talisman --scanWithHtml
  echo "Talisman Report Server is starting http://localhost:64999"
  echo ""
  python3 -m http.server 64999 --directory "$SCRIPT_DIR/talisman_html_report/"
}

self_update() {
  curl -L https://gist.githubusercontent.com/hozgan/1abd8f8978775230af38df0a34e3124a/raw/talisman.sh -o $SCRIPT_DIR/talisman.sh && chmod +x $SCRIPT_DIR/talisman.sh
}

install_hooks() {
  install_pre_push
  install_pre_commit
}

install_pre_push() {
  if [ -f $SCRIPT_DIR/.git/hooks/pre-push ]; then
    echo "âœ… pre-push hook already installed"
  else
    echo "âš¡ï¸ pre-push hook installing"
    $HOME/install-talisman.sh
  fi
}

install_pre_commit() {
  if [ -f $SCRIPT_DIR/.git/hooks/pre-commit ]; then
    echo "âœ… pre-commit hook already installed"
  else
    echo "âš¡ï¸ pre-commit hook installing"
    $HOME/install-talisman.sh pre-commit
  fi
}

install_deps() {
  install_script
  install_report
}

install_script() {
  curl https://thoughtworks.github.io/talisman/install.sh > $TALISMAN_INSTALL_SCRIPT && chmod +x $TALISMAN_INSTALL_SCRIPT
}

install_report() {
  curl https://github.com/jaydeepc/talisman-html-report/archive/v${TALISMAN_REPORT_VERSION}.zip -o ~/.talisman/talisman_html_report.zip -J -L && cd ~/.talisman && unzip talisman_html_report.zip -d . && mv talisman-html-report-${TALISMAN_REPORT_VERSION} talisman_html_report && rm talisman_html_report.zip
}

uninstall_hooks() {
  uninstall_pre_push
  uninstall_pre_commit
}

uninstall_pre_push() {
  if [ -f $SCRIPT_DIR/.git/hooks/pre-push ]; then
    mv $SCRIPT_DIR/.git/hooks/pre-push $SCRIPT_DIR/.git/hooks/pre-push-$(date '+%Y%m%d%H%M%S').bak
    echo "âŒ pre-push uninstalled"
  else
    echo "ðŸ’¡ pre-push is not installed"
  fi
}

uninstall_pre_commit() {
  if [ -f $SCRIPT_DIR/.git/hooks/pre-commit ]; then
    mv $SCRIPT_DIR/.git/hooks/pre-commit $SCRIPT_DIR/.git/hooks/pre-commit-$(date '+%Y%m%d%H%M%S').bak
    echo "âŒ pre-commit uninstalled"
  else
    echo "ðŸ’¡ pre-commit is not installed"
  fi
}

clean_reports() {
  if [ -d $SCRIPT_DIR/talisman_html_report ]; then
    rm -rf $SCRIPT_DIR/talisman_html_report
    echo "ðŸ’¡ talisman_html_report removed"
  fi

  if [ -d $SCRIPT_DIR/talisman_report ]; then
    rm -rf $SCRIPT_DIR/talisman_report
    echo "ðŸ’¡ talisman_report removed"
  fi
}

uninstall_deps() {
  if [ -f "$TALISMAN_INSTALL_SCRIPT" ]; then
    rm $TALISMAN_INSTALL_SCRIPT
    echo "âŒ install-talisman.sh uninstalled"
  else
    echo "ðŸ’¡ install-talisman.sh is not installed"
  fi

  if [ -d "$TALISMAN_HTML_REPORT" ]; then
    rm -rf $HOME/.talisman/talisman_html_report
    echo "âŒ talisman_html_report uninstalled"
  else
    echo "ðŸ’¡ talisman_html_report is not installed"
  fi
}

add_gitignore() {
  echo "" >> .gitignore
  echo "### Talisman ###" >> .gitignore
  echo ".talismanrc" >> .gitignore
  echo "talisman_report/" >> .gitignore
  echo "talisman_html_report/" >> .gitignore
  echo "" >> .gitignore
}

print_usage() (
    cat <<EOF
usage: $NAME <command>
commands:
  report
    Show git history talisman report
  clean
    Delete talisman_html_report and talisman_report folders
  add-gitignore
    Add talisman gitignore files
  self-update
    Update talisman script
  install
    Install githooks for pre-commit, pre-push
  uninstall
    Uninstall githooks for pre-commit, pre-push
  install-deps
    Install talisman-install.sh script and talisman_report
  uninstall-deps
    Uninstall talisman-install.sh script and talisman_report
  -v, --version
    Show the version of $NAME.
  -h, --help
    Show this help.
EOF
    if [ -z "$1" ]; then exit 0; else exit 1; fi
)

case $1 in
  report)
    check_deps
    pre_install
    talisman_report
    ;;
  clean)
    clean_reports
    ;;
  add-gitignore)
    add_gitignore
    ;;
  self-update)
    self_update
    ;;
  install)
    check_deps
    install_hooks
    ;;
  uninstall)
    check_deps
    uninstall_hooks
    ;;
  install-deps)
    install_deps
    ;;
  uninstall-deps)
    uninstall_deps
    ;;
  -h | --help)
    print_usage
    ;;
  -v | --version)
    echo "talisman.sh version is ${VERSION}"
    ;;
  "")
    $SCRIPT_DIR/.git/hooks/bin/talisman --githook pre-commit
    ;;
esac