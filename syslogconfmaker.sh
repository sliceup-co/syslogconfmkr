#!/bin/bash


echo -e "\e[96m Enter the IP address of the syslog server \e[39m" 
read syslogip
echo " "
echo " " 
echo -e "\e[96m Is this the Prime server? [Y/n] \e[39m" 
read a

###clear config if there
echo "###Load Module###" > /etc/rsyslog.d/slicesys.conf
echo "\$ModLoad imfile" >> /etc/rsyslog.d/slicesys.conf

echo "############ create flink .log files ###########" >> /etc/rsyslog.d/slicesys.conf
echo " " >> /etc/rsyslog.d/slicesys.conf
files=$(ls  /opt/sliceup/executables/flink-1.10.0/log/*.log | xargs -n1 basename)

loglist_array=($files)
    for filelist in "${loglist_array[@]}" 
        do 

               clean_name=$(echo $filelist | sed 's/-//'g | sed 's/.log//'g)
    
                echo "### $filelist" >> /etc/rsyslog.d/slicesys.conf

                echo "\$InputFileName /opt/sliceup/executables/flink-1.10.0/log/$filelist" >> /etc/rsyslog.d/slicesys.conf

                echo "\$InputFileTag $clean_name:" >> /etc/rsyslog.d/slicesys.conf

                echo "\$InputFileStateFile /tmp/$clean_name" >> /etc/rsyslog.d/slicesys.conf

                echo "\$InputFileSeverity info" >> /etc/rsyslog.d/slicesys.conf

                echo "\$InputFileFacility local3" >> /etc/rsyslog.d/slicesys.conf

                echo "\$InputRunFileMonitor" >> /etc/rsyslog.d/slicesys.conf
		
		echo " " >> /etc/rsyslog.d/slicesys.conf
        done
echo " " >> /etc/rsyslog.d/slicesys.conf
echo "############ create flink .out files ###########" >> /etc/rsyslog.d/slicesys.conf
echo " " >> /etc/rsyslog.d/slicesys.conf
files=$(ls  /opt/sliceup/executables/flink-1.10.0/log/*.out | xargs -n1 basename)

loglist_array=($files)
    for filelist in "${loglist_array[@]}" 
        do 

               clean_name=$(echo $filelist | sed 's/-//'g | sed 's/.out//'g)
    
                echo "### $filelist" >> /etc/rsyslog.d/slicesys.conf

                echo "\$InputFileName /opt/sliceup/executables/flink-1.10.0/log/$filelist" >> /etc/rsyslog.d/slicesys.conf

                echo "\$InputFileTag $clean_name:" >> /etc/rsyslog.d/slicesys.conf

                echo "\$InputFileStateFile /tmp/$clean_name" >> /etc/rsyslog.d/slicesys.conf

                echo "\$InputFileSeverity info" >> /etc/rsyslog.d/slicesys.conf

                echo "\$InputFileFacility local3" >> /etc/rsyslog.d/slicesys.conf

                echo "\$InputRunFileMonitor" >> /etc/rsyslog.d/slicesys.conf
		echo " " >> /etc/rsyslog.d/slicesys.conf
        done

echo " " >> /etc/rsyslog.d/slicesys.conf



	if [ "$a" = "Y" ] || [ "$a" = "y" ]; then


            echo "########## Create Kafka files ################" >> /etc/rsyslog.d/slicesys.conf
            echo " " >> /etc/rsyslog.d/slicesys.conf
            files=$(ls  /opt/sliceup/executables/kafka_2.12-2.4.1/logs/*.log | xargs -n1 basename)

            loglist_array=($files)
                for filelist in "${loglist_array[@]}" 
                    do 
                          
		             #add kafka to name if missing
             		   clean_name=$(echo $filelist | sed 's/-//'g | sed 's/.log//'g)
                               kafka_check=$(echo "$clean_name" | grep kaf)
                            if [ -z "$kafka_check" ]
                           		 then
                                  		kafka_plus=$(echo "kafka$clean_name")
	                             else
                                  kafka_plus=$(echo $clean_name)
                            fi

                            echo "### $filelist" >> /etc/rsyslog.d/slicesys.conf

                            echo "\$InputFileName /opt/sliceup/executables/kafka_2.12-2.4.1/logs/$filelist" >> /etc/rsyslog.d/slicesys.conf

                            echo "\$InputFileTag $kafka_plus:" >> /etc/rsyslog.d/slicesys.conf

                            echo "\$InputFileStateFile /tmp/$clean_name" >> /etc/rsyslog.d/slicesys.conf

                            echo "\$InputFileSeverity info" >> /etc/rsyslog.d/slicesys.conf

                            echo "\$InputFileFacility local3" >> /etc/rsyslog.d/slicesys.conf

                            echo "\$InputRunFileMonitor" >> /etc/rsyslog.d/slicesys.conf
		                    echo " " >> /etc/rsyslog.d/slicesys.conf
                    done

                                echo "#########Device is Prime config Postgress & GrafanaLogs##########" >> /etc/rsyslog.d/slicesys.conf
                                echo " " >> /etc/rsyslog.d/slicesys.conf
	                 
                                echo "######PostGres" >> /etc/rsyslog.d/slicesys.conf
                        
                                echo "\$InputFileName /var/log/postgresql/postgresql-10-main.log" >> /etc/rsyslog.d/slicesys.conf

                                echo "\$InputFileTag postgres10:" >> /etc/rsyslog.d/slicesys.conf

                                echo "\$InputFileStateFile /tmp/postgres10" >> /etc/rsyslog.d/slicesys.conf

                                echo "\$InputFileSeverity info" >> /etc/rsyslog.d/slicesys.conf

                                echo "\$InputFileFacility local3" >> /etc/rsyslog.d/slicesys.conf

                                echo "\$InputRunFileMonitor" >> /etc/rsyslog.d/slicesys.conf
		                        echo " " >> /etc/rsyslog.d/slicesys.conf
                           

                                echo "########Grafana" >> /etc/rsyslog.d/slicesys.conf

                                echo "\$InputFileName /var/log/grafana/grafana.log" >> /etc/rsyslog.d/slicesys.conf

                                echo "\$InputFileTag grafana:" >> /etc/rsyslog.d/slicesys.conf

                                echo "\$InputFileStateFile /tmp/grafana" >> /etc/rsyslog.d/slicesys.conf

                                echo "\$InputFileSeverity info" >> /etc/rsyslog.d/slicesys.conf

                                echo "\$InputFileFacility local3" >> /etc/rsyslog.d/slicesys.conf

                                echo "\$InputRunFileMonitor" >> /etc/rsyslog.d/slicesys.conf
		                        echo " " >> /etc/rsyslog.d/slicesys.conf

                                sudo chmod a+r /var/log/grafana/grafana.log

	fi

echo "######### Add remote destination ##########" >> /etc/rsyslog.d/slicesys.conf

echo "*.*  @@$syslogip:514" >> /etc/rsyslog.d/slicesys.conf
##############change grafana log permissions############

