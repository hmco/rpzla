
This directory contains example configuration for BIND.
They are not perfect or in any way professional, but are
included to give an overview of how to configure BIND to
use a reputation provider and show an example of a locally
configured RPZ source.

named.conf.sanitised

  The BIND config using both and external reputation 
  provider (via zone transfer) as a locally accessible
  recursive resolver.

rpz.you.tld.zone

  An example of the data file for a locally defined 
  set of 'nasty' domains.

