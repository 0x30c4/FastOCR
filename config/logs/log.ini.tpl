[loggers]
keys=root

[handlers]
keys=logfile,logconsole

[formatters]
keys=logformatter

[logger_root]
level=INFO
handlers=logfile, logconsole

[formatter_logformatter]
format=[%(asctime)s.%(msecs)03d] %(levelname)s [%(thread)d] - %(message)s

[handler_logfile]
class=handlers.RotatingFileHandler
level=INFO
args=('$APP_LOG_FILE','a')
formatter=logformatter

[handler_logconsole]
class=handlers.logging.StreamHandler
level=INFO
args=()
formatter=logformatter
