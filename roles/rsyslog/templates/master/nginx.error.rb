version=2

rule=php_message_upstream: PHP message: PHP %php_level:char-to::%:" %php_msg:char-to:,%, client: %client:ipv4%, server: %server:char-to:,%, request: "%verb:word% %urlpath:char-to:\x20% HTTP/%httpver:char-to:"%", upstream: "%upstream:op-quoted-string%", host: "%hostname:char-to:"%"


rule=php_message_article: message repeated %repeated:number% times: [PHP message: PHP %php_level:char-to::%: %php_msg:rest%

rule=php_message_noupstream: PHP message: PHP %php_level:char-to::%:" %php_msg:char-to:,%, client: %client:ipv4%, server: %server:char-to:,%, request: "%verb:word% %urlpath:char-to:\x20% HTTP/%httpver:char-to:"%", host: %hostname:op-quoted-string%
rule=php_message: PHP message: PHP %php_level:char-to::%: %php_msg:rest%

rule=fast_cgi: %date_string:char-to:\x20% %time:time-24hr% [%level:char-to:\x5D%] %f1:char-to::%: %f2:char-to:\x20% FastCGI sent in stderr: "PHP message: PHP %php_level:char-to::%: %php_msg:rest%
rule=fast_cgi_nomsg: %date_string:char-to:\x20% %time:time-24hr% [%level:char-to:\x5D%] %f1:char-to::%: %f2:char-to:\x20% FastCGI sent in stderr: "%php_msg:rest%

rule=not_found: %date_string:char-to:\x20% %time:time-24hr% [%level:char-to:\x5D%] %f1:char-to::%: %f2:char-to:\x20% %errmsg:char-to:,%, client: %client:ipv4%, server: %server:char-to:,%, request: "%verb:word% %urlpath:char-to:\x20% HTTP/%httpver:char-to:"%", host: %hostname:op-quoted-string%
rule=not_found_upstream: %date_string:char-to:\x20% %time:time-24hr% [%level:char-to:\x5D%] %f1:char-to::%: %f2:char-to:\x20% %errmsg:char-to:,%, client: %client:ipv4%, server: %server:char-to:,%, request: "%verb:word% %urlpath:char-to:\x20% HTTP/%httpver:char-to:"%", upstream: %upstream:op-quoted-string%, host: "%hostname:char-to:"%"
rule=not_found_upstream_referrer: %date_string:char-to:\x20% %time:time-24hr% [%level:char-to:\x5D%] %f1:char-to::%: %f2:char-to:\x20% %errmsg:char-to:,%, client: %client:ipv4%, server: %server:char-to:,%, request: "%verb:word% %urlpath:char-to:\x20% HTTP/%httpver:char-to:"%", upstream: %upstream:op-quoted-string%, host: "%hostname:char-to:"%", referrer: "%referrer:char-to:"%"
rule=not_found_referrer: %date_string:char-to:\x20% %time:time-24hr% [%level:char-to:\x5D%] %f1:char-to::%: %f2:char-to:\x20% %errmsg:char-to:,%, client: %client:ipv4%, server: %server:char-to:,%, request: "%verb:word% %urlpath:char-to:\x20% HTTP/%httpver:char-to:"%", host: "%hostname:char-to:"%", referrer: "%referrer:char-to:"%"
rule=blank_not_found: %date_string:char-to:\x20% %time:time-24hr% [%level:char-to:\x5D%] %f1:char-to::%: %f2:char-to:\x20% %errmsg:char-to:,%, client: %client:ipv4%, server: %server:char-to:,%, request: "%verb:word% %urlpath:char-to:\x20% HTTP/%httpver:char-to:"%", host: %hostname:op-quoted-string%
