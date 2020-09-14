# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([Schema for XML Catalogs],[0],[https://github.com/webb/schema-for-xml-catalog/issues],[schema-for-xml-catalog],[https://github.com/webb/schema-for-xml-catalog])

# Checks for programs.
# AC_PROG_INSTALL
# AC_PROG_MKDIR_P
# AC_PROG_SED

# AC_PATH_PROG(var,prog)
# test "x$var" = "x" && AC_MSG_ERROR([var not found])

# AC_PATH_PROG(same,same)
# test "x$same" = "x" && AC_MSG_ERROR([same not found])

AC_PATH_PROG(bash,bash)
test "x$bash" = "x" && AC_MSG_ERROR([bash not found])

AC_PATH_PROG(curl,curl)
test "x$curl" = "x" && AC_MSG_ERROR([curl not found])

AC_PATH_PROG(schematron_compile,schematron-compile)
test "x$schematron_compile" = "x" && AC_MSG_ERROR([schematron_compile not found])

AC_CONFIG_FILES([Makefile], [chmod 444 Makefile])
AC_SUBST([config_files],$ac_config_files)
AC_OUTPUT
