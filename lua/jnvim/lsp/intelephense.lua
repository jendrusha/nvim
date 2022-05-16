return {
    init_options = {
        globalStoragePath = "/home/jendrusha/.intelephense",
        storagePath = "/tmp/intelephense",
        licenceKey = "00KTUF22RD520J9",
        usePlaceholders = true,
        completeUnimported = true,
    },
	capabilities = {
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true,
				}
			}
		}
	},
    settings = {
        intelephense = {
            licenceKey = "00KTUF22RD520J9",
            stubs = {
                "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "csprng", "ctype", "curl",
                "date", "dba", "dom", "enchant", "exif", "fileinfo", "filter", "fpm", "ftp", "gd", "grpc",
                "hash", "iconv", "imap", "interbase", "intl", "json", "ldap", "libxml", "mbstring",
                "mcrypt", "mssql", "mysql", "mysqli", "oci8", "odcb", "openssl", "password", "pcntl",
                "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar",
                "posix", "protobuf", "pspell", "readline", "recode", "Reflection", "regex", "session",
                "shmop", "SimpleXML", "snmp", "soap", "sockets", "sodium", "SPL", "sqlite3", "standard",
                "superglobals", "sybase", "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer", "wddx",
                "xml", "xmlreader", "xmlrpc", "xmlwriter", "Zend OPcache", "zip", "zlib", "amqp"
            },
            environment = {
                phpVersion = "8.0.1"
                -- phpVersion = "7.4.13"
            },
            files = {
                maxSize = 10000000,
                exclude = {
                    "**/.git/**",
                    "**/node_modules/**",
                    "**/vendor/**/{Tests,tests}/**",
                    "**/vendor/**/vendor/**",
                }
            },
            completion = {
                fullyQualifyGlobalConstantsAndFunctions = false,
                insertUseDeclaration = true,
                triggerParameterHints = true,
            },
            phpdoc = {
                textFormat = "snippet",
                useFullyQualifiedNames = false,
                returnVoid = true,
                propertyTemplate = {
                    summary = "$1",
                    tags = {
                        "@var ${1:$SYMBOL_TYPE}",
                    }
                },
                functionTemplate = {
                    summary = "$1",
                    tags = {
                        "@param ${1:$SYMBOL_TYPE} $SYMBOL_NAME $2",
                        "@return ${1:$SYMBOL_TYPE} $2",
                        "@throws ${1:$SYMBOL_TYPE} $2"
                    }
                },
                classTemplate = {
                    summary = "$1",
                    tags = {
                        "@package ${1:$SYMBOL_NAMESPACE}",
                    }
                }
            },
            format = {
                enable = true
            }
        }
    }
}
