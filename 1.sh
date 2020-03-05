#!/bin/bash
#Проверка на число
function isNumber()
{
        if [ -z "$1" ]
                then
                        return 0;
        fi

        re='^[0-9]+$'

        if ! [[ $1 =~ $re ]] ;
                then
                        return 0;
                else
                        return 1;
        fi
}

echo "---------------------------------------------------"
echo "******** Скрипт Ретинского Максима"
echo "******** Группы 726"
echo "---------------------------------------------------"
echo "******** Скрипт изменяет пароль пользователя"
echo "******** и устанавливает максимальное и минимальное"
echo "******** время жизни пароля"                                                                                                                                     
echo "---------------------------------------------------"

while :
do
        #-------------------------------------------------------------------------------------------------------------------
        echo "Введите имя пользователя: "
        read user_name

        while :
        do
                grep $user_name /etc/passwd >/dev/null
                if [ $? -ne 0 ];
                        then
                                echo "Пользователь не найден"
                                echo "Введите имя пользователя:"
                                read user_name
                        else
                                break
                fi
        done

        #------------------------------------------------------------------------------------------------------------------
        echo "Введите минимальное кол-во дней перед сменой пароля:"
        read min_date

 	while :
        do
                isNumber $min_date
                return_val=$?
                if [ $return_val -eq 0 ]
                        then
                                echo "Введено не число!"
                                echo "Введите минимальное кол-во дней перед сменой пароля:"
                                read min_date
                        else
                                break
                fi
        done

        #-----------------------------------------------------------------------------------------------------------------                                                      
	echo "Введите максимальное кол-во дней перед сменой пароля:"                                                                                                            
	read max_date

	while :
        do
                isNumber $max_date
                return_val=$?
                if [ $return_val -eq 0 ]
                        then
                                echo "Введено не число!"
                                echo "Введите максимальное кол-во дней перед сменой пароля:"
                                read max_date
                        else
                                break
                fi
        done

        #----------------------------------------------------------------------------------------------------------------
        echo "Введите новый пароль:"
        read pass

	echo -e $pass"\n"$pass"\n" | passwd $user_name
        passwd --minimum=$min_date --maximum=$max_date $user_name

        while :
        do
                echo "Повторить? (y/n)"
                read answer
                if [[ $answer == "y" || $answer == "Y" || $answer  == "n" || $answer == "N" ]]
                        then
                                if [[ $answer == "n" || $answer == "N" ]]
                                        then
                                                exit 0
                                        else
                                                break
                                fi
                        else
                                echo "Ошибка ввода"
                fi
        done
done  

  