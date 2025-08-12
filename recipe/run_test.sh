#!/bin/bash

set -exuo pipefail

openldap_libraries=(
    "liblber"
    "libldap"
)

openldap_headers=(
    "lber.h"
    "lber_types.h"
    "ldap.h"
    "ldap_cdefs.h"
    "ldap_features.h"
    "ldap_schema.h"
    "ldap_utf8.h"
    "ldif.h"
    "openldap.h"
    "slapi-plugin.h"
)

openldap_binaries=(
    "ldapcompare"
    "ldapdelete"
    "ldapexop"
    "ldapmodify"
    "ldapmodrdn"
    "ldappasswd"
    "ldapsearch"
    "ldapurl"
    "ldapvc"
    "ldapwhoami"
)

for each_library in "${openldap_libraries[@]}"; do
    test -f ${PREFIX}/lib/"$each_library".a
    test -f ${PREFIX}/lib/"$each_library"${SHLIB_EXT}
done

for each_header in "${openldap_headers[@]}"; do
    test -f ${PREFIX}/include/"$each_header"
done

for each_binary in "${openldap_binaries[@]}"; do
    test -f ${PREFIX}/bin/"$each_binary"
done