
DBQuery.shellBatchSize = 30000


// https://stackoverflow.com/a/9998010/4709762
//
// Convert GUID string to Base-64 in Javascript
// by Mark Seecof, 2012-03-31

var hexlist = '0123456789abcdef';
var b64list = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

// GUID string with four dashes is always MSB first,
// but base-64 GUID's vary by target-system endian-ness.
// Little-endian systems are far more common.  Set le==true
// when target system is little-endian (e.g., x86 machine).
//
function guid_to_base64(g, le) {
    var s = g.replace(/[^0-9a-f]/ig, '').toLowerCase();
    if (s.length != 32) return '';

    if (le) s = s.slice(6, 8) + s.slice(4, 6) + s.slice(2, 4) + s.slice(0, 2) +
      s.slice(10, 12) + s.slice(8, 10) +
      s.slice(14, 16) + s.slice(12, 14) +
      s.slice(16);
    s += '0';

    var a, p, q;
    var r = '';
    var i = 0;
    while (i < 33) {
      a = (hexlist.indexOf(s.charAt(i++)) << 8) |
        (hexlist.indexOf(s.charAt(i++)) << 4) |
        (hexlist.indexOf(s.charAt(i++)));

      p = a >> 6;
      q = a & 63;

      r += b64list.charAt(p) + b64list.charAt(q);
    }
    r += '==';

    return r;
  } // guid_to_base64()

