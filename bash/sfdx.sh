# sfdx: Salesforce CLI:
# https://trailhead.salesforce.com/en/content/learn/projects/quick-start-salesforce-dx/set-up-your-salesforce-dx-environment

if command -v sfdx &>/dev/null; then
  eval "$(sfdx autocomplete:script bash)"
fi
