#!/usr/bin/env bash
set -euo pipefail

mkdir -p "${HOME}/.openbb_platform"

cat > "${HOME}/.openbb_platform/user_settings.json" <<EOF
{
  "defaults": {
    "commands": {
      "/equity/profile": { "provider": "${OPENBB_PROVIDER_COMPANY_PROFILE:-yfinance}" },
      "/news/company": { "provider": "${OPENBB_PROVIDER_COMPANY_NEWS:-yfinance}" },
      "/equity/fundamental/filings": { "provider": "${OPENBB_PROVIDER_COMPANY_FILINGS:-sec}" },
      "/equity/price/quote": { "provider": "${OPENBB_PROVIDER_MARKET_QUOTE:-yfinance}" },
      "/equity/price/historical": { "provider": "${OPENBB_PROVIDER_MARKET_HISTORICAL:-yfinance}" },
      "/fixedincome/rate/effr": { "provider": "${OPENBB_PROVIDER_MACRO_EFFR:-federal_reserve}" },
      "/fixedincome/government/treasury_rates": { "provider": "${OPENBB_PROVIDER_MACRO_TREASURY:-federal_reserve}" }
    }
  }
}
EOF

exec uvicorn openbb_core.api.rest_api:app --host 0.0.0.0 --port "${PORT:-8000}"
