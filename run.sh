#!/bin/sh
skip=49

tab='	'
nl='
'
IFS=" $tab$nl"

umask=`umask`
umask 77

gztmpdir=
trap 'res=$?
  test -n "$gztmpdir" && rm -fr "$gztmpdir"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15

case $TMPDIR in
  / | /*/) ;;
  /*) TMPDIR=$TMPDIR/;;
  *) TMPDIR=/tmp/;;
esac
if type mktemp >/dev/null 2>&1; then
  gztmpdir=`mktemp -d "${TMPDIR}gztmpXXXXXXXXX"`
else
  gztmpdir=${TMPDIR}gztmp$$; mkdir $gztmpdir
fi || { (exit 127); exit 127; }

gztmp=$gztmpdir/$0
case $0 in
-* | */*'
') mkdir -p "$gztmp" && rm -r "$gztmp";;
*/*) gztmp=$gztmpdir/`basename "$0"`;;
esac || { (exit 127); exit 127; }

case `printf 'X\n' | tail -n +1 2>/dev/null` in
X) tail_n=-n;;
*) tail_n=;;
esac
if tail $tail_n +$skip <"$0" | gzip -cd > "$gztmp"; then
  umask $umask
  chmod 700 "$gztmp"
  (sleep 5; rm -fr "$gztmpdir") 2>/dev/null &
  "$gztmp" ${1+"$@"}; res=$?
else
  printf >&2 '%s\n' "Cannot decompress $0"
  (exit 127); res=127
fi; exit $res
��jbrun.sh �R]o�0}��mlK�4!�&�U��P��Mca��1_���R��*m~���{�}�χ+� 2�)3yaBm.�Jn��P�l��Y���\���e���H�O��K����k����5�p�@U�`��*_���:0�3����gN.���$�\0A��As�k����9��SI	��"�m�d�q��
QK�Z�
�-Q4��}��|M��^`����s�c"E�XO�y|��'�ޢ���<��!̣V��"�LHJ	��6O���a6�ݯ�z߯G�߫��V��H�va}�/�m�
>YS	_�
���n](���84�7#h�M�5�(@%	Y�_��K�A������Iţm�(4��D���$1���p.�{2$X�	�n3�!��}��M�ɇJ���URTS����_��ޓ3����5;~p�?�
�?V�<�Id�Фp���"~�z䇚�64B��d��q��(k���^��n���!�l웗
�I�:,V��,��2  