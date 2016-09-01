modcut() { awk '
/==============/{do_print=1}
{if($0 ~ "-A--"){do_print=1}}
{if($0 ~ "-C--"){do_print=1}}
{if($0 ~ "-I--"){do_print=0}}
{if($0 ~ "-E--"){do_print=0}}
{if($0 ~ "-B--"){do_print=1}}
{if($0 ~ "-F--"){do_print=1}}
{if($0 ~ "-H--"){do_print=1}}
{if($0 ~ "-K--"){do_print=0}}
{if($0 ~ "-Z--"){do_print=1}}
do_print==1 {print}
'; }

MODAUDIT() {
        sed 's/&/\n&\n/g' | \
        php -r "echo urldecode(file_get_contents('php://stdin'));" | \
        sed 's/=\(.*\)/='`echo -e '\033[0;33m'`'\1'`echo -e '\033[0;0m'`'/g' | \
        sed 's/\(id "[0-9]*"\)/'`echo -e '\033[0;31m'`'\1'`echo -e '\033[0;0m'`'/g' | \
        sed 's/\(\[data "Matched Data:[^"]*"\]\)/'`echo -e '\033[0;32m'`'\1'`echo -e '\033[0;0m'`'/g' | \
        less -r
}

CPUBENCH() {
        local CPU="$1"
        local SCALE="$2"
        [ "$CPU" == "" ] && CPU="1"; [ "$SCALE" == "" ] && SCALE="5000"
        if [ "$CPU" -eq "$CPU" ] 2>/dev/null; then echo -n; else CPU=1; fi
        { for LOOP in `seq 1 $CPU`; do { time echo "scale=${SCALE}; 4*a(1)" | bc -l -q | grep -v ^"[0-9]" & }   ; done  ; }
        echo "Kerne: $CPU"
        echo "Kommastellen: $SCALE"
}
