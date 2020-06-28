version=2

rule=pm2-date-space: %date:date-rfc5424% %errmsg:rest%
rule=pm2-space: %errmsg:rest%

rule=pm2-date:%date:date-rfc5424% %errmsg:rest%
rule=pm2:%errmsg:rest%
