PingIP=1.2.3.4
LocalIP=5.6.7.8
Time=30
Parallel=2
Port=9001
Bandwidth='100.0K'
TTL=1
Transmit=100

echo "Run as Client (C) or Server (S)?"
read ClientServer

if [ $ClientServer == 'S' ]
then echo "logfile iperfServer">>~/.screenrc
then screen -dmSL iperfServer iperf -s -u -P 0 -i 1 -p $Port -C -f k
sleep 3
then ssh probe1@SERVERIP 'iperf -c $LocalIP -u -P $Parallel -i $Transmit -p 9001 -f k -b $Bandwidth -t $Time -T $TTL'
fi

if [ $ClientServer == 'C' ]
then ssh probe1@SERVERIP 'iperf -s -u -P 0 -i 1 -p 9001 -C -f k'
then echo "logfile iperfClient">>~/.screenrc
sleep 3
then screen -dmSL iperfClient iperf -c PingIP -u -P $Parallel -i $Transmit -p $Port -f k -b $Bandwidth -t $Time -T $TTL
fi
