#!/bin/bash
n=0
ADS=("SXtm:EU-FRANKFURT-1-AD-1" "SXtm:EU-FRANKFURT-1-AD-2" "SXtm:EU-FRANKFURT-1-AD-3")

until [ "$n" -ge 300 ]
do
  AD=${ADS[$((n % ${#ADS[@]}))]}
  echo "[$(date)] Retry Attempt — $n | Trying AD: $AD"
  terraform apply -auto-approve -var="availability_domain=$AD" && exit 0
  n=$((n+1))
  sleep 60
done

echo "Couldnt create instance." >&2
exit 1
