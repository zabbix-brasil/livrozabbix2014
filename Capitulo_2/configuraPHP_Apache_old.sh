cp /etc/php.ini /etc/php.ini.ori;
sed -i 's/max_execution_time/\;max_execution_time/g' /etc/php.ini;
echo ' max_execution_time=300'>> /etc/php.ini;
sed -i 's/max_input_time/\;max_input_time/g' /etc/php.ini;
echo 'max_input_time=300' >> /etc/php.ini;
sed -i 's/date.timezone/\;date.timezone/g' /etc/php.ini;
echo ' date.timezone=America/Sao_Paulo' >> /etc/php.ini;

sed -i 's/post_max_size/\;post_max_size/g' /etc/php.ini;
echo ' post_max_size=16M' >> /etc/php.ini;

service apache2 restart