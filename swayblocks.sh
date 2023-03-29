progressbar="▰▰▰▰▰▰▰▰▰▰▱▱▱▱▱▱▱▱▱▱"

cpu_percent=$(mpstat 1 1 | awk '/Average:/  {printf("%.0f", 100-$NF) }')
mem_percent=$(free -k | awk '/Mem:/ { printf( "%.0f", $3/( $2/100 ) ) }' )
ssd_percent=$( df / | awk 'NR==2 {sub(/%/, "", $5); print $5}' )

echo $(swaymsg -t subscribe -m '["window"]' | jq -r '.container.name')


#cpu_temp: $(sensors | awk '/Tctl:/ {printf("%s", $2)}') | \
#gpu_temp: $(sensors | awk '/junction:/ {printf("%s", $2)}' ) | \


echo "CPU: $cpu_percent% ${progressbar:$(( 10-cpu_percent/10  )):10}  |  \
RAM: $mem_percent% ${progressbar:$(( 10-mem_percent/10 )):10}  |  \
SSD: $ssd_percent% ${progressbar:$(( 10-ssd_percent/10 )):10}  |  \
$(date +'%d-%m-%Y %H:%M ')"
