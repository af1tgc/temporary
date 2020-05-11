#!/bin/sh

LANG=C
export LANG

alias ls=ls

CREATE_FILE=`hostname`"_solaris_"`date +%m%d`.txt
CHECK_FILE=`ls ./"$CREATE_FILE" 2>/dev/null | wc -l`

perm_check() {
    unset FUNC_FILE
    unset PERM
    unset NUM
    unset PERM_CHECK
    unset OWNER_FUNC_RESULT
    unset PERM_FUNC_RESULT
    unset VALUE

    FUNC_FILE=$1
    PERM=`ls -alL $FUNC_FILE | awk '{print $1}'`
    OWNER_FUNC_RESULT=`ls -al $FUNC_FILE | awk '{print $3}'`
    PERM=`expr "$PERM" : '.\(.*\)' | sed -e "s/-/A/g"`;

    while :
    do
        NUM=`echo $PERM | awk '{print length($0)}'`

        if [ $NUM -eq 0 ]
            then
                break
        fi

        PERM_CHECK=`expr "$PERM" : '\(...\).*'`
        PERM=`expr "$PERM" : '...\(.*\)'`

        if [ "$PERM_CHECK" = "rwx" -o "$PERM_CHECK" = "rws" -o "$PERM_CHECK" = "rwS" ]
            then
                VALUE="7"
        fi

        if [ "$PERM_CHECK" = "rwA" ]
            then
                VALUE="6"
        fi

        if [ "$PERM_CHECK" = "rAx" -o "$PERM_CHECK" = "rAs" -o "$PERM_CHECK" = "rAS" ]
            then
                VALUE="5"
        fi

        if [ "$PERM_CHECK" = "rAA" ]
            then
                VALUE="4"
        fi

        if [ "$PERM_CHECK" = "Awx" -o "$PERM_CHECK" = "Aws" -o "$PERM_CHECK" = "AwS" ]
            then
                VALUE="3"
        fi

        if [ "$PERM_CHECK" = "AwA" ]
            then
                VALUE="2"
        fi

        if [ "$PERM_CHECK" = "AAx" -o "$PERM_CHECK" = "AAs" -o "$PERM_CHECK" = "AAS" ]
            then
                VALUE="1"
        fi

        if [ "$PERM_CHECK" = "AAA" ]
            then
                VALUE="0"
        fi

        PERM_FUNC_RESULT=$PERM_FUNC_RESULT" "$VALUE
    done

    PERM_FUNC_RESULT=$PERM_FUNC_RESULT" "$OWNER_FUNC_RESULT

    return
}

perm_check_dir() {
    unset FUNC_FILE
    unset PERM
    unset OWNER_FUNC_RESULT
    unset NUM
    unset PERM_CHECK
    unset PERM_FUNC_RESULT
    unset VALUE

    FUNC_FILE=$1

    PERM=`ls -alLd $FUNC_FILE | awk '{print $1}'`
    OWNER_FUNC_RESULT=`ls -alLd $FUNC_FILE | awk '{print $3}'`
    PERM=`expr "$PERM" : '.\(.*\)' | sed -e "s/-/A/g"`

    while :
    do
        NUM=`echo $PERM | awk '{print length($0)}'`

        if [ $NUM -eq 0 ]
            then
                break
        fi

        PERM_CHECK=`expr "$PERM" : '\(...\).*'`
        PERM=`expr "$PERM" : '...\(.*\)'`

        if [ "$PERM_CHECK" = "rwx" -o "$PERM_CHECK" = "rws" -o "$PERM_CHECK" = "rwS" ]
            then
                VALUE="7"
        fi

        if [ "$PERM_CHECK" = "rwA" ]
            then
                VALUE="6"
        fi

        if [ "$PERM_CHECK" = "rAx" -o "$PERM_CHECK" = "rAs" -o "$PERM_CHECK" = "rAS" ]
            then
                VALUE="5"
        fi

        if [ "$PERM_CHECK" = "rAA" ]
            then
                VALUE="4"
        fi

        if [ "$PERM_CHECK" = "Awx" -o "$PERM_CHECK" = "Aws" -o "$PERM_CHECK" = "AwS" ]
            then
                VALUE="3"
        fi

        if [ "$PERM_CHECK" = "AwA" ]
            then
                VALUE="2"
        fi

        if [ "$PERM_CHECK" = "AAx" -o "$PERM_CHECK" = "AAs" -o "$PERM_CHECK" = "AAS" ]
            then
                VALUE="1"
        fi

        if [ "$PERM_CHECK" = "AAA" ]
            then
                VALUE="0"
        fi

        PERM_FUNC_RESULT=$PERM_FUNC_RESULT" "$VALUE
    done

    PERM_FUNC_RESULT=$PERM_FUNC_RESULT" "$OWNER_FUNC_RESULT

    return
}

SOL_VERSION="1"
SOL_NAME=""

while [ 1 ]
do
	echo "Solaris 버전을 선택해주세요."
	echo "1) Solaris 9  이하"
	echo "2) Solaris 10 이상"

	read SOL_VERSION

	if [ $SOL_VERSION != "1" -a $SOL_VERSION != "2" ]
		then
			echo "잘못 입력하였습니다. (1 / 2) 를 입력해주세요."
			echo ""
			SOL_VERSION=""
	else
		if [ $SOL_VERSION = "1" ]
			then
				SOL_NAME="Solaris 9 이하"
		elif [ $SOL_VERSION = "2" ]
			then
				SOL_NAME="Solaris 10 이상"
		fi

		/usr/ucb/echo -n "[$SOL_NAME] 를 선택하였습니다[y/n] : [ENTER = y]"
		
		read TRY_CMD
		if [ "$TRY_CMD" = "y" -o "$TRY_CMD" = "Y" -o "$TRY_CMD" = "" ]
			then
				break				
		fi
	fi
done		

echo > $CREATE_FILE 2>&1

echo "INFO_CHKSTART"  >> $CREATE_FILE 2>&1
echo >> $CREATE_FILE 2>&1

echo "###################################   SUN Security Check        ######################################"
echo "###################################   SUN Security Check      ######################################" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "############################################ Start Time ################################################"
date
echo " "
echo "############################################ Start Time ################################################" >> $CREATE_FILE 2>&1
date >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "=================================== System Information Query Start ====================================="
echo "=================================== System Information Query Start =====================================" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "#######################################   Kernel Information   #########################################"
echo "#######################################   Kernel Information   #########################################" >> $CREATE_FILE 2>&1
uname -a >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "#########################################   IP Information   ###########################################"
echo "#########################################   IP Information   ###########################################" >> $CREATE_FILE 2>&1
ifconfig -a >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "#########################################   Network Status   ###########################################"
echo "#########################################   Network Status   ###########################################" >> $CREATE_FILE 2>&1
netstat -an | egrep -i "LISTEN|ESTABLISHED" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "#######################################   Routing Information   ########################################"
echo "#######################################   Routing Information   ########################################" >> $CREATE_FILE 2>&1
netstat -rn >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "##########################################   Process Status   ##########################################"
echo "##########################################   Process Status   ##########################################" >> $CREATE_FILE 2>&1
ps -ef >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "##########################################   User Env   ################################################"
echo "##########################################   User Env   ################################################" >> $CREATE_FILE 2>&1
env >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "##########################################  shadow_passwd  #############################################"
echo "##########################################  shadow_passwd  #############################################" >> $CREATE_FILE 2>&1
cat /etc/shadow > `hostname`_passwd.txt
echo " " >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1


echo "=================================== System Information Query End ======================================="
echo "=================================== System Information Query End =======================================" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "INFO_CHKEND"  >> $CREATE_FILE 2>&1

echo >> $CREATE_FILE 2>&1
echo "********************************************* START ****************************************************" >> $CREATE_FILE 2>&1
echo >> $CREATE_FILE 2>&1
echo
echo "********************************************* START ****************************************************"
echo
echo >> $CREATE_FILE 2>&1

echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo >> $CREATE_FILE 2>&1
echo "INFO_CHKEND"  >> $CREATE_FILE 2>&1

su1_01() {
echo "1.01 START" >> $CREATE_FILE 2>&1
echo "############################ 1.계정관리 - 1.1 관리자 및 사용자 계정 UID(GID) 중복 ##########################################"
echo "############################ 1.계정관리 - 1.1 관리자 및 사용자 계정 UID(GID) 중복 ##########################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : root 계정만이 UID가 0이면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
if [ -f /etc/passwd ]
  then
    awk -F: '$3==0 { print $1 " -> UID=" $3 }' /etc/passwd >> $CREATE_FILE 2>&1
  else
    echo "/etc/passwd 파일이 없습니다." >> $CREATE_FILE 2>&1
fi

echo " " >> $CREATE_FILE 2>&1

echo "☞ /etc/passwd 파일 내용" >> $CREATE_FILE 2>&1
cat /etc/passwd >> $CREATE_FILE 2>&1

if [ `awk -F: '$3==0  { print $1 }' /etc/passwd | grep -v "root" | wc -l` -eq 0 ]
  then
    echo "● 1.01 결과 : 양호" >> $CREATE_FILE 2>&1
  else
    echo "● 1.01 결과 : 취약" >> $CREATE_FILE 2>&1
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "1.01 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su1_02() {
echo "1.02 START" >> $CREATE_FILE 2>&1
echo "############################ 1.계정관리 - 1.2 불필요한 계정 관리 ########################################"
echo "############################ 1.계정관리 - 1.2 불필요한 계정 관리 ########################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : /etc/passwd파일에 기본계정이나 test, 1234 등의 계정이 존재할 경우 취약" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

vul_state=0
cat /etc/passwd >> $CREATE_FILE 2>&1

if [ `cat /etc/passwd |awk -F: '{print $1}' | egrep "test" | wc -l` -ge 1 ]; then
    vul_state=1
fi

if [ $vul_state -eq 1 ]; then
	echo "● 1.02 결과 : 취약" >> $CREATE_FILE 2>&1
else
	echo "● 1.02 결과 : 수동" >> $CREATE_FILE 2>&1
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "1.02 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su1_03() {
echo "1.03 START" >> $CREATE_FILE 2>&1
echo "############################ 1.계정관리 - 1.3 Shell 제한 ###############################################"
echo "############################ 1.계정관리 - 1.3 Shell 제한 ###############################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : 로그인이 필요하지 않은 시스템 계정에 /bin/false(nologin) 쉘이 부여되어 있으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
if [ -f /etc/passwd ]
  then
    cat /etc/passwd | egrep "^daemon|^bin|^sys|^adm|^listen|^nobody|^nobody4|^noaccess|^diag|^listen|^operator|^games|^gopher" | grep -v "admin" >> $CREATE_FILE 2>&1
  else
    echo "/etc/passwd 파일이 없습니다." >> $CREATE_FILE 2>&1
fi

if [ `cat /etc/passwd | egrep "^daemon|^bin|^sys|^adm|^listen|^nobody|^nobody4|^noaccess|^diag|^listen|^operator|^games|^gopher" | grep -v "admin" |  awk -F: '{print $7}'| egrep -v 'false|nologin|null|halt|sync|shutdown' | wc -l` -eq 0 ]
  then
    echo "● 1.03 결과 : 양호" >> $CREATE_FILE 2>&1
  else
    echo "● 1.03 결과 : 취약" >> $CREATE_FILE 2>&1
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "1.03 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su1_04() {
echo "1.04 START" >> $CREATE_FILE 2>&1
echo "############################ 1.계정관리 - 1.4 패스워드 정책설정 ##################################"
echo "############################ 1.계정관리 - 1.4 패스워드 정책설정 ##################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : 패스워드 최소 길이가 8자이상, 최대 사용기간이 12주이하, 최소 사용기간이 1주로 설정되어 있으면 양호(내부규정에 따라 설정)" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
if [ -f /etc/default/passwd ]
  then
    grep -v '^ *#' /etc/default/passwd | grep -i "PASSLENGTH" >> $CREATE_FILE 2>&1
  else
    echo "/etc/default/passwd 파일이 없습니다." >> $CREATE_FILE 2>&1
fi
echo " " >> $CREATE_FILE 2>&1

if [ -f /etc/default/passwd ]
  then
    grep -v '^ *#' /etc/default/passwd | grep -i "MAXWEEKS" >> $CREATE_FILE 2>&1
  else
    echo "/etc/default/passwd 파일이 없습니다." >> $CREATE_FILE 2>&1
fi
echo " " >> $CREATE_FILE 2>&1

if [ -f /etc/default/passwd ]
  then
    grep -v '^ *#' /etc/default/passwd | grep -i "MINWEEKS" >> $CREATE_FILE 2>&1
  else
    echo "/etc/default/passwd 파일이 없습니다." >> $CREATE_FILE 2>&1
fi

echo " " > passwordpolicy.txt

if [ `cat /etc/default/passwd | grep -i "PASSLENGTH" | grep -v "#" | egrep [0-9]| awk '{print $2}'| wc -l` -eq 0 ]
  then
    echo "● 1.04 결과 : 취약" >> passwordpolicy.txt
  else
    if [ `cat /etc/default/passwd | grep -i "PASSLENGTH" | grep -v "#" | awk 'BEGIN {FS="="}{print $2}'` -ge 8 ]
      then
        echo "● 1.04 결과 : 양호" >> passwordpolicy.txt
      else
        echo "● 1.04 결과 : 취약" >> passwordpolicy.txt
    fi
fi

if [ `cat /etc/default/passwd | grep -i "MAXWEEKS" | grep -v "#" | egrep  [0-9]| awk  '{print $2}'| wc -l ` -eq 0 ]
 then
    echo "● 1.04 결과 : 취약" >> passwordpolicy.txt
 else
   if [  `cat /etc/default/passwd | grep -i "MAXWEEKS" | grep -v "#" | awk 'BEGIN {FS="="}{print $2}'` -le 12 ]
    then
     echo "● 1.04 결과 : 양호" >> passwordpolicy.txt
    else
     echo "● 1.04 결과 : 취약" >> passwordpolicy.txt
   fi
fi

if [ `cat /etc/default/passwd | grep -i "MINWEEKS" | egrep [0-9] | grep -v "#" | awk -F= '{print $2}'| wc -l` -eq 0 ]
 then
   echo "● 1.04 결과 : 취약" >> passwordpolicy.txt
 else
 if [ `cat /etc/default/passwd | grep -i "MINWEEKS" |  grep -v "#" | awk 'BEGIN {FS="="}{print $2}'` -eq 1 ]
   then
     echo "● 1.04 결과 : 양호" >> passwordpolicy.txt
   else
     echo "● 1.04 결과 : 취약" >> passwordpolicy.txt
  fi
fi

if [ `cat passwordpolicy.txt | grep "취약" | wc -l` -eq 0 ]
 then
  echo "● 1.04 결과 : 양호" >> $CREATE_FILE 2>&1
 else
  echo "● 1.04 결과 : 취약" >> $CREATE_FILE 2>&1
fi

rm -rf passwordpolicy.txt
echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "1.04 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su1_05() {
echo "1.05 START" >> $CREATE_FILE 2>&1
echo "############################ 1.계정관리 - 1.5 SU 명령어 제한  ##################################################"
echo "############################ 1.계정관리 - 1.5 SU 명령어 제한  ##################################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "기준 : /usr/bin/su 파일 권한이 4750 이면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
if [ -f /usr/bin/su ]
  then
    ls -alL /usr/bin/su >> $CREATE_FILE 2>&1
  else
    echo " /usr/bin/su 파일 없습니다." >> $CREATE_FILE 2>&1
fi

if [ -f /usr/bin/su ]
  then
   if [ `ls -alL /usr/bin/su | grep ".....-.---" | wc -l` -eq 1 ]
     then
       echo "● 1.05 결과 : 양호" >> $CREATE_FILE 2>&1
     else
       echo "● 1.05 결과 : 취약" >> $CREATE_FILE 2>&1
   fi
  else
    echo "● 1.05 결과 : 취약" >> $CREATE_FILE 2>&1
fi
echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "1.05 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su1_06() {
echo "1.06 START" >> $CREATE_FILE 2>&1
echo "############################ 1.계정관리 - 1.6 취약한 패스워드 사용 ########################################"
echo "############################ 1.계정관리 - 1.6 취약한 패스워드 사용 ########################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : John the Ripper를 이용해서 크랙킹되는 패스워드가 없으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
if [ -f /etc/passwd ]
  then
    echo "☞ /etc/passwd 파일 " >> $CREATE_FILE 2>&1
    cat /etc/passwd >> $CREATE_FILE 2>&1
  else
    echo "/etc/passwd 파일이 없습니다. " >> $CREATE_FILE 2>&1
fi

if [ -f /etc/shadow ]
  then
    echo "☞ /etc/shadow 파일 " >> $CREATE_FILE 2>&1
    cat /etc/shadow >> $CREATE_FILE 2>&1
  else
    echo "/etc/shadow 파일이 없습니다. " >> $CREATE_FILE 2>&1
fi

echo "● 1.06 결과 : 수동" >> $CREATE_FILE 2>&1
echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "1.06 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su1_07() {
echo "1.07 START" >> $CREATE_FILE 2>&1
echo "############################ 1.계정관리 - 1.7 패스워드 파일 Shadowing ###########################################"
echo "############################ 1.계정관리 - 1.7 패스워드 파일 Shadowing ###########################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : /etc/passwd의 두번째 필드가 'x'로 되어 있고, /etc/shadow 가 존재하면 양호">> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
if [ -f /etc/shadow ]
  then
    if [ `cat /etc/passwd | awk -F":" 'length($2) > 0 {print $2}' | sort -u |grep -v "x" | wc -l` -eq 0 ]
	then
		echo "☞ /etc/passwd 파일 " >> $CREATE_FILE 2>&1
		cat /etc/passwd >> $CREATE_FILE 2>&1
		echo "● 1.07 결과 : 양호" >> $CREATE_FILE 2>&1
	else
		echo "☞ /etc/passwd 파일 " >> $CREATE_FILE 2>&1
		cat /etc/passwd >> $CREATE_FILE 2>&1
		echo "● 1.07 결과 : 취약" >> $CREATE_FILE 2>&1
	fi
  else
    echo "/etc/shadow 파일이 없습니다." >> $CREATE_FILE 2>&1
    echo "● 1.07 결과 : 취약" >> $CREATE_FILE 2>&1
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "1.07 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su1_08() {
echo "1.08 START" >> $CREATE_FILE 2>&1
echo "############################ 1.계정관리 - 1.8 로그인 설정(Solaris Only) ##############################################"
echo "############################ 1.계정관리 - 1.8 로그인 설정(Solaris Only) ##############################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : /etc/default/login 파일에 PASSREQ=YES 설정이 있으면 양호">> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
if [ -f /etc/default/login ]
  then
    cat /etc/default/login | grep -i "PASSREQ" | grep "=" >> $CREATE_FILE 2>&1
  else
    echo "/etc/default/login 파일이 없습니다." >> $CREATE_FILE 2>&1
fi

if [ `cat /etc/default/login | grep -i "PASSREQ" | grep "YES" | grep "#"` ]
    then
      echo "● 1.08 결과 : 취약" >> $CREATE_FILE 2>&1
    else
      if [ `cat /etc/default/login | grep -i "PASSREQ=YES"` ]
          then
            echo "● 1.08 결과 : 양호" >> $CREATE_FILE 2>&1
          else
            echo "● 1.08 결과 : 취약" >> $CREATE_FILE 2>&1
      fi
fi
echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "1.08 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su2_01() {
echo "2.01 START" >> $CREATE_FILE 2>&1
echo "############################ 2.접근통제 - 2.1 계정 관련 파일의 접근권한 설정 ####################################"
echo "############################ 2.접근통제 - 2.1 계정 관련 파일의 접근권한 설정 ##########################3#########" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : /etc/passwd, /etc/group 파일의 권한이 444 또는 644이고 /etc/shadow  파일의 권한이 400 또는 600이면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
if [ -f /etc/passwd ]
  then
    ls -alL /etc/passwd >> $CREATE_FILE 2>&1
  else
    echo "/etc/passwd 파일이 없습니다." >> $CREATE_FILE 2>&1
fi
echo " " >> $CREATE_FILE 2>&1

if [ -f /etc/group ]
  then
    ls -alL /etc/group >> $CREATE_FILE 2>&1
  else
    echo " /etc/group 파일이 없습니다." >> $CREATE_FILE 2>&1
fi
echo " " >> $CREATE_FILE 2>&1

if [ -f /etc/shadow  ]
  then
    ls -alL /etc/shadow >> $CREATE_FILE 2>&1
  else
    echo " /etc/shadow  파일이 없습니다." >> $CREATE_FILE 2>&1
fi

echo " " > userfile.txt
if [ -f /etc/passwd ]
  then
if [ `ls -alL /etc/passwd | grep "...-.--.--" | wc -l` -eq 1 ]
  then
    echo "● 2.01 결과 : 양호" >> userfile.txt
  else
    echo "● 2.01 결과 : 취약" >> userfile.txt
fi
else
 echo "● 2.01 결과 : 양호" >> userfile.txt
fi

if [ -f /etc/group ]
  then
if [ `ls -alL /etc/group |  grep "...-.--.--" | awk '{print $1}' | wc -l` -eq 1 ]
      then
        echo "● 2.01 결과 : 양호" >> userfile.txt
      else
        echo "● 2.01 결과 : 취약" >> userfile.txt
fi
else
 echo "● 2.01 양호" >> userfile.txt
fi

if [ -f /etc/shadow ]
  then
if [ `ls -alL /etc/shadow | grep ".r.-------" | wc -l` -eq 1 ]
  then
    echo "● 2.01 결과 : 양호" >> userfile.txt
  else
    echo "● 2.01 결과 : 취약" >> userfile.txt
fi
else
 echo "● 2.01 결과 : 양호" >> userfile.txt
fi

if [ `cat userfile.txt | grep "취약" | wc -l` -eq 0 ]
 then
  echo "● 2.01 결과 : 양호" >> $CREATE_FILE 2>&1
 else
  echo "● 2.01 결과 : 취약" >> $CREATE_FILE 2>&1
fi

rm -rf userfile.txt
echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "2.01 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su2_02() {
echo "2.02 START" >> $CREATE_FILE 2>&1
echo "############################ 2.접근통제 - 2.2 주요 디렉터리 접근권한 설정 ####################################"
echo "############################ 2.접근통제 - 2.2 주요 디렉터리 접근권한 설정 ##########################3#########" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : 소유주가 root(bin or sys)이며, 다른사용자(Other)의 쓰기 권한이 없을 경우 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
    FILE="/etc /bin /usr/bin /sbin /usr/sbin"
   
    echo "☞ 주요 디렉터리의 소유자 및 접근권한 상태" >> $CREATE_FILE 2>&1

    for check_dir in $FILE
    do
        if [ -d $check_dir ]
            then
                perm_check_dir $check_dir

                OWNER_PERM=`echo $PERM_FUNC_RESULT | awk '{print $1}'`
                GROUP_PERM=`echo $PERM_FUNC_RESULT | awk '{print $2}'`
                OTHER_PERM=`echo $PERM_FUNC_RESULT | awk '{print $3}'`
                RESULT_OWNER=`echo $PERM_FUNC_RESULT | awk '{print $4}'`

                echo `ls -ald $check_dir` >> $CREATE_FILE 2>&1

                if [ $RESULT_OWNER != "root" -o $GROUP_PERM -gt 5 -o $OTHER_PERM -gt 5 ]
                    then
                        REGUL_SET=$REGUL_SET+$check_dir
                fi
        fi
    done

    if [ "$REGUL_SET" != "" ]
        then
            echo "● 2.02 결과 : 취약" >> $CREATE_FILE 2>&1
    else
        echo "● 2.02 결과 : 양호" >> $CREATE_FILE 2>&1
    fi

    unset FILE
    unset OWNER_PERM
    unset GROUP_PERM
    unset OTHER_PERM
    unset REGUL_SET
    unset RESULT_OWNER
echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "2.02 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su2_03() {
echo "2.03 START" >> $CREATE_FILE 2>&1
echo "############################ 2.접근통제 - 2.3 홈 디렉터리 접근권한 설정 ##################################"
echo "############################ 2.접근통제 - 2.3 홈 디렉터리 접근권한 설정 ##################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : 홈 디렉터리에 타사용자 쓰기권한이 없으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
HOMEDIRS=`cat /etc/passwd | awk -F":" 'length($6) > 0 {print $6}' | sort -u | grep -v "#" | grep -v "/tmp" | grep -v "uucppublic" | uniq`
         for dir in $HOMEDIRS
          do
            ls -dal $dir | grep '\d.........' >> $CREATE_FILE 2>&1
         done

echo " " > home.txt
HOMEDIRS=`cat /etc/passwd | awk -F":" 'length($6) > 0 {print $6}' | sort -u | grep -v "#" | grep -v "/tmp" | grep -v "uucppublic" | uniq`
         for dir in $HOMEDIRS
          do
               if [ -d $dir ]
               then
                if [ `ls -dal $dir |  awk '{print $1}' | grep "........-." | wc -l` -eq 1 ]
                then
                  echo "● 2.03 결과 : 양호" >> home.txt
                 else
                  echo "● 2.03 결과 : 취약" >> home.txt
                fi
              else
                echo "● 2.03 결과 : 양호" >> home.txt
              fi
         done

if [ `cat home.txt | grep "취약" | wc -l` -eq 0 ]
 then
  echo "● 2.03 결과 : 양호" >> $CREATE_FILE 2>&1
 else
  echo "● 2.03 결과 : 취약" >> $CREATE_FILE 2>&1
fi

rm -rf home.txt
unset HOMEDIRS

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "2.03 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su2_04() {
echo "2.04 START" >> $CREATE_FILE 2>&1
echo "############################ 2.접근통제 - 2.4 홈디렉터리 환경변수 파일 접근권한 설정 #####################"
echo "############################ 2.접근통제 - 2.4 홈디렉터리 환경변수 파일 접근권한 설정 #####################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : 홈디렉터리 환경변수 파일이 타사용자에게 쓰기 권한이 없으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
HOMEDIRS=`cat /etc/passwd | awk -F":" 'length($6) > 0 {print $6}' | sort -u | grep -v '/bin/false' | grep -v 'nologin' | grep -v "#"`
FILES=".profile .cshrc .kshrc .login .bash_profile .bashrc .bash_login .exrc .netrc .history .sh_history .bash_history .dtprofile"

for file in $FILES
  do
    FILE=/$file
    if [ -f $FILE ]
      then
        ls -al $FILE >> $CREATE_FILE 2>&1
    fi
  done

for dir in $HOMEDIRS
do
  for file in $FILES
  do
    FILE=$dir/$file
    if [ -f $FILE ]
      then
        ls -al $FILE >> $CREATE_FILE 2>&1
    fi
  done
done

echo " " > home2.txt

HOMEDIRS=`cat /etc/passwd | awk -F":" 'length($6) > 0 {print $6}' | sort -u | grep -v '/bin/false' | grep -v 'nologin' | grep -v "#"`
FILES=".profile .cshrc .kshrc .login .bash_profile .bashrc .bash_login .exrc .netrc .history .sh_history .bash_history .dtprofile"

for file in $FILES
          do
            if [ -f /$file ]
             then
             if [ `ls -alL /$file |  awk '{print $1}' | grep "........-." |grep -v "lrwxrwxrwx" | wc -l` -eq 1 ]
              then
                echo "● 2.04 결과 : 양호" >> home2.txt
              else
                echo "● 2.04 결과 : 취약" >> home2.txt
             fi
            else
              echo "● 2.04 결과 : 양호"   >> home2.txt
            fi
         done

 for dir in $HOMEDIRS
    do
        for file in $FILES
          do
            if [ -f $dir/$file ]
             then
             if [ `ls -al $dir/$file | awk '{print $1}' | grep "........-." |grep -v "lrwxrwxrwx" | wc -l` -eq 1 ]
              then
                echo "● 2.04 결과 : 양호" >> home2.txt
              else
                echo "● 2.04 결과 : 취약" >> home2.txt
             fi
            else
              echo "● 2.04 결과 : 양호" >> home2.txt
            fi
         done
    done

if [ `cat home2.txt | grep "취약" | wc -l` -eq 0 ]
 then
  echo "● 2.04 결과 : 양호" >> $CREATE_FILE 2>&1
 else
  echo "● 2.04 결과 : 취약" >> $CREATE_FILE 2>&1
fi

rm -rf home2.txt
unset HOMEDIRS
unset FILES
echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "2.04 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su2_05() {
echo "2.05 START" >> $CREATE_FILE 2>&1
echo "############################ 2.접근통제 - 2.5 네트워크 서비스 설정파일의 접근권한 설정 ####################################"
echo "############################ 2.접근통제 - 2.5 네트워크 서비스 설정파일의 접근권한 설정 ##########################3#########" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : /etc/hosts /etc/inet/hosts /etc/inetd.conf /etc/serveces /etc/inet/inetd.conf /etc/inet/services /etc/inittab 의 권한이 타사용자 쓰기권한이 없으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
if [ -f /etc/hosts ]
  then
    ls -alL /etc/hosts >> $CREATE_FILE 2>&1
   else
    echo "/etc/hosts 파일이 없습니다." >> $CREATE_FILE 2>&1
fi

if [ -f /etc/services ]
  then
   ls -alL /etc/services  >> $CREATE_FILE 2>&1
  else
   echo " /etc/services 파일이 없습니다."  >> $CREATE_FILE 2>&1
fi

if [ -f /etc/inetd.conf ]
  then
    ls -alL /etc/inetd.conf >> $CREATE_FILE 2>&1
  else
    echo " /etc/inetd.conf 파일이 없습니다." >> $CREATE_FILE 2>&1
fi

if [ -f /etc/inet/hosts ]
  then
    ls -alL /etc/inet/hosts >> $CREATE_FILE 2>&1
  else
    echo " /etc/inet/hosts 파일이 없습니다." >> $CREATE_FILE 2>&1
fi

if [ -f /etc/inet/inetd.conf ]
  then
    ls -alL /etc/inet/inetd.conf >> $CREATE_FILE 2>&1
  else
    echo " /etc/inet/inetd.conf 파일이 없습니다." >> $CREATE_FILE 2>&1
fi

if [ -f /etc/inet/services ]
  then
    ls -alL /etc/inet/services >> $CREATE_FILE 2>&1
  else
    echo " /etc/inet/services 파일이 없습니다." >> $CREATE_FILE 2>&1
fi

if [ -f /etc/inittab ]
  then
    ls -alL /etc/inittab >> $CREATE_FILE 2>&1
  else
    echo " /etc/inittab 파일이 없습니다." >> $CREATE_FILE 2>&1
fi

echo " " > etcfiles.txt

if [ -f /etc/inet/hosts ]
then
if [ `ls -alL /etc/inet/hosts | awk '{print $1}' | grep '........-.'| wc -l` -eq 1 ]
  then
    echo "● 2.05 결과 : 양호" >> etcfiles.txt
  else
    echo "● 2.05 결과 : 취약" >> etcfiles.txt
fi
else
 echo "● 2.05 결과 : 양호" >> etcfiles.txt
fi

if [ -f /etc/inet/inetd.conf ]
then
if [ `ls -alL /etc/inet/inetd.conf | awk '{print $1}' | grep '........-.'| wc -l` -eq 1 ]
  then
    echo "● 2.05 결과 : 양호" >> etcfiles.txt
  else
    echo "● 2.05 결과 : 취약" >> etcfiles.txt
fi
else
 echo "● 2.05 결과 : 양호" >> etcfiles.txt
fi

if [ -f /etc/hosts ]
then
if [ `ls -alL /etc/hosts | awk '{print $1}' | grep '........-.'| wc -l` -eq 1 ]
  then
    echo "● 2.05 결과 : 양호" >> etcfiles.txt
  else
    echo "● 2.05 결과 : 취약" >> etcfiles.txt
fi
else
 echo "● 2.05 결과 : 양호" >> etcfiles.txt
fi

if [ -f /etc/services ]
then
  if [ `ls -alL /etc/services | awk '{print $1}' | grep '........-.' | wc -l` -eq 1 ]
              then
                echo "● 2.05 결과 : 양호" >> etcfiles.txt
              else
                echo "● 2.05 결과 : 취약" >> etcfiles.txt
  fi
else
  echo "● 2.05 결과 : 양호" >> etcfiles.txt
fi

if [ -f /etc/inet/services ]
then
  if [ `ls -alL /etc/inet/services | awk '{print $1}' | grep '........-.' | wc -l` -eq 1 ]
              then
                echo "● 2.05 결과 : 양호" >> etcfiles.txt
              else
                echo "● 2.05 결과 : 취약" >> etcfiles.txt
  fi
else
  echo "● 2.05 결과 : 양호" >> etcfiles.txt
fi

if [ -f /etc/inittab ]
then
  if [ `ls -alL /etc/inittab | awk '{print $1}' | grep '........-.' | wc -l` -eq 1 ]
              then
                echo "● 2.05 결과 : 양호" >> etcfiles.txt
              else
                echo "● 2.05 결과 : 취약" >> etcfiles.txt
  fi
else
  echo "● 2.05 결과 : 양호" >> etcfiles.txt
fi

if [ -f /etc/inetd.conf ]
then
if [ `ls -alL /etc/inetd.conf | awk '{print $1}' | grep '........-.'| wc -l` -eq 1 ]
  then
    echo "● 2.05 결과 : 양호" >> etcfiles.txt
  else
    echo "● 2.05 결과 : 취약" >> etcfiles.txt
fi
else
 echo "● 2.05 결과 : 양호" >> etcfiles.txt
fi

if [ `cat etcfiles.txt | grep "취약" | wc -l` -eq 0 ]
 then
  echo "● 2.05 결과 : 양호" >> $CREATE_FILE 2>&1
 else
  echo "● 2.05 결과 : 취약" >> $CREATE_FILE 2>&1
fi

rm -rf etcfiles.txt
echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "2.05 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su2_06() {
echo "2.06 START" >> $CREATE_FILE 2>&1
echo "############################ 2.접근통제 - 2.6 ftp 접근제어 파일권한 설정 ############################"
echo "############################ 2.접근통제 - 2.6 ftp 접근제어 파일권한 설정 ############################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : ftpusers 파일이 타사용자 쓰기권한이 없으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

if [ -f /etc/ftpd/ftpusers ]
  then
   ls -alL /etc/ftpd/ftpusers  >> $CREATE_FILE 2>&1
  else
   echo " /etc/ftpd/ftpusers 파일이 없습니다."  >> $CREATE_FILE 2>&1
fi

echo " " >> $CREATE_FILE 2>&1

if [ -f /etc/ftpusers ]
  then
   ls -alL /etc/ftpusers  >> $CREATE_FILE 2>&1
  else
   echo " /etc/ftpusers 파일이 없습니다."  >> $CREATE_FILE 2>&1
fi

echo "  " > ftpusers.txt

if [ -f /etc/ftpd/ftpusers ]
 then
     if [ `ls -alL /etc/ftpd/ftpusers | awk '{print $1}' | grep '........-.' | wc -l` -eq 0 ]
              then
                echo "● 2.06 결과 : 취약" >> ftpusers.txt
              else
                echo "● 2.06 결과 : 양호" >> ftpusers.txt
     fi
 else
  echo "no-file"  >> ftpusers.txt
fi

if [ -f /etc/ftpusers ]
then
 if [ `ls -alL /etc/ftpusers | awk '{print $1}' | grep '........-.'| wc -l` -eq 0 ]
   then
     echo "● 2.06 결과 : 취약" >> ftpusers.txt
   else
     echo "● 2.06 결과 : 양호" >> ftpusers.txt
 fi
else
  echo "no-file"  >> ftpusers.txt
fi

if [ `cat ftpusers.txt | grep "취약" | wc -l` -gt 0 ]
 then
   echo "● 2.06 결과 : 취약" >> $CREATE_FILE 2>&1
 else
   echo "● 2.06 결과 : 양호" >> $CREATE_FILE 2>&1
fi

rm -rf ftpusers.txt

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "2.06 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su2_07() {
echo "2.07 START" >> $CREATE_FILE 2>&1
echo "############################ 2.접근통제 - 2.7 root 원격 접근제어 파일권한 설정 #####################"
echo "############################ 2.접근통제 - 2.7 root 원격 접근제어 파일권한 설정 #####################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : /etc/default/login 파일이 타사용자에게 쓰기권한이 없으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
if [ -f /etc/default/login ]
  then
   ls -alL /etc/default/login  >> $CREATE_FILE 2>&1
  else
   echo " /etc/default/login 파일이 없습니다"  >> $CREATE_FILE 2>&1
fi

if [ -f /etc/default/login ]
  then
    if [ `ls -alL /etc/default/login |  awk '{print $1}' | grep '........-.'| wc -l` -eq 0 ]
       then
          echo "● 2.07 결과 : 취약" >> $CREATE_FILE 2>&1
       else
          echo "● 2.07 결과 : 양호" >> $CREATE_FILE 2>&1
    fi
  else
   echo "● 2.07 결과 : 양호"  >> $CREATE_FILE 2>&1
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "2.07 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su2_08() {
echo "2.08 START" >> $CREATE_FILE 2>&1
echo "############################ 2.접근통제 - 2.8 NFS 접근제어 파일권한 설정 ###########################"
echo "############################ 2.접근통제 - 2.8 NFS 접근제어 파일권한 설정 ###########################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : /etc/dfs/dfstab 파일이 타사용자 쓰기권한 없으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
if [ -f  /etc/dfs/dfstab ]
  then
   ls -alL /etc/dfs/dfstab  >> $CREATE_FILE 2>&1
  else
   echo " /etc/dfs/dfstab 파일이 없습니다"  >> $CREATE_FILE 2>&1
fi

if [ -f /etc/dfs/dfstab ]
  then
   if [ `ls -alL /etc/dfs/dfstab |  awk '{print $1}' | grep '........-.'| wc -l` -eq 1 ]
       then
          echo "● 2.08 결과 : 양호" >> $CREATE_FILE 2>&1
       else
          echo "● 2.08 결과 : 취약" >> $CREATE_FILE 2>&1
   fi
  else
   echo "● 2.08 결과 : 양호" >> $CREATE_FILE 2>&1
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "2.08 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su2_09() {
echo "2.09 START" >> $CREATE_FILE 2>&1
echo "############################ 2.접근통제 - 2.9 SNMP 설정파일 접근권한 설정 ###########################"
echo "############################ 2.접근통제 - 2.9 SNMP 설정파일 접근권한 설정 ###########################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : /etc/snmp/conf/snmpd.conf 파일이 타사용자 쓰기권한 없으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
if [ -f  /etc/snmp/conf/snmpd.conf ]
  then
   ls -alL /etc/snmp/conf/snmpd.conf  >> $CREATE_FILE 2>&1
  else
   echo " /etc/snmp/conf/snmpd.conf 파일이 없습니다"  >> $CREATE_FILE 2>&1
fi

if [ -f /etc/snmp/conf/snmpd.conf ]
  then
   if [ `ls -alL /etc/snmp/conf/snmpd.conf |  awk '{print $1}' | grep '........-.'| wc -l` -eq 1 ]
       then
          echo "● 2.09 결과 : 양호" >> $CREATE_FILE 2>&1
       else
          echo "● 2.09 결과 : 취약" >> $CREATE_FILE 2>&1
   fi
  else
   echo "● 2.09 결과 : 양호" >> $CREATE_FILE 2>&1
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "2.09 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su2_10() {
echo "2.10 START" >> $CREATE_FILE 2>&1
echo "############################ 2.접근통제 - 2.10 R 서비스 설정파일 접근권한 설정 ########################"
echo "############################ 2.접근통제 - 2.10 R 서비스 설정파일 접근권한 설정 ########################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : 설정 파일 (hosts.equiv, $HOME/.rhosts)의 권한이 400(600)이거나 존재하지 않을 경우 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

HOMEDIRS=`cat /etc/passwd | awk -F":" 'length($6) > 0 {print $6}' | sort -u`
FILES="/.rhosts"

for dir in $HOMEDIRS
   do
     for file in $FILES
     do
       if [ -f $dir$file ]
       then
        echo "- $dir/.rhosts 권한 설정" >> $CREATE_FILE 2>&1
        ls -al $dir$file  >> $CREATE_FILE 2>&1
        echo " " >> $CREATE_FILE 2>&1
       fi
      done
   done

if [ -f /etc/hosts.equiv ]
then
 ls -al /etc/hosts.equiv >> $CREATE_FILE 2>&1
else
 echo "해당 파일이 없습니다." >> $CREATE_FILE 2>&1
fi

echo "  " > rhosts.txt

for dir in $HOMEDIRS
do
  for file in $FILES
  do
    if [ -f $dir$file ]
     then
       if [ `ls -al $dir$file | awk '{print $1}' | grep '...-------' | wc -l` -eq 1 ]
       then
         echo "● 2.10 결과 : 양호" >> rhosts.txt
       else
         if [ `ls -al $dir$file | grep '\/dev\/null' | wc -l` -eq 1 ]
          then
           echo "● 2.10 결과 : 양호" >> rhosts.txt
          else
           echo "● 2.10 결과 : 취약" >> rhosts.txt
         fi
       fi
     else
       echo "● 2.10 결과 : 양호" >> rhosts.txt
     fi
  done
done

if [ -f /etc/hosts.equiv ]
then
    if [ `ls -al /etc/hosts.equiv | awk '{print $1}' | grep '...-------' | wc -l ` -eq 1 ]
     then
       echo "● 2.10 결과 : 양호" >> rhosts.txt
     else
       if [ `ls -al /etc/hosts.equiv | grep '\/dev\/null' | wc -l` -eq 1 ]
          then
           echo "● 2.10 결과 : 양호" >> rhosts.txt
          else
           echo "● 2.10 결과 : 취약" >> rhosts.txt
       fi
    fi
else
  echo "● 2.10 결과 : 양호" >> rhosts.txt
fi

if [ `cat rhosts.txt | grep "취약" | wc -l` -gt 0 ]
 then
  echo "● 2.10 결과 : 취약" >> $CREATE_FILE 2>&1
 else
  echo "● 2.10 결과 : 양호" >> $CREATE_FILE 2>&1
fi

rm -rf rhosts.txt
unset HOMEDIRS
unset FILES

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "2.10 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su2_11() {
echo "2.11 START" >> $CREATE_FILE 2>&1
echo "############################ 2.접근통제 - 2.11 syslog.conf 파일 접근권한 설정 ####################################"
echo "############################ 2.접근통제 - 2.11 syslog.conf 파일 접근권한 설정 ##########################3#########" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : syslog.conf 파일의 권한이 타사용자에게 쓰기권한이 없으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
if [ -f /etc/syslog.conf ]
  then
    ls -alL /etc/syslog.conf >> $CREATE_FILE 2>&1
  else
    echo "/etc/syslog.conf 파일이 없습니다." >> $CREATE_FILE 2>&1
fi

if [ `ls -alL /etc/syslog.conf | awk '{print $1}' | grep '........w.' | wc -l` -eq 0 ]
  then
    echo "● 2.11 결과 : 양호" >> $CREATE_FILE 2>&1
  else
    echo "● 2.11 결과 : 취약" >> $CREATE_FILE 2>&1
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "2.11 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su2_12() {
echo "2.12 START" >> $CREATE_FILE 2>&1
echo "############################ 2.접근통제 - 2.12 Cron 파일 접근권한 설정 #########################"
echo "############################ 2.접근통제 - 2.12 Cron 파일 접근권한 설정 #########################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : Crontab 관련 파일에 타사용자에게 쓰기권한이 없으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
cro="/var/spool/cron/crontabs/*"

for check_dir in $cro; do
	if [ -f $check_dir ]; then
		ls -alL $check_dir >> $CREATE_FILE 2>&1
	else
		echo $check_dir " 이 없습니다." >> $CREATE_FILE 2>&1
	fi
done

cro="/var/spool/cron/crontabs/*"

echo " " > crontab.txt
for check_dir in $cro; do
	if [  `ls -alL $check_dir | awk '{print $1}' |grep  '........w.' |wc -l` -eq 0 ]; then
		echo "● 2.12 결과 : 양호" >> crontab.txt
	else
		echo "● 2.12 결과 : 취약" >> crontab.txt
	fi
done

if [ `cat crontab.txt | grep "취약" | wc -l` -eq 0 ]; then
	echo "● 2.12 결과 : 양호" >> $CREATE_FILE 2>&1
else
	echo "● 2.12 결과 : 취약" >> $CREATE_FILE 2>&1
fi

rm -rf crontab.txt

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "2.12 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su2_13() {
echo "2.13 START" >> $CREATE_FILE 2>&1
echo "############################ 2.접근통제 - 2.13 로그 파일 접근권한 설정 ######################################"
echo "############################ 2.접근통제 - 2.13 로그 파일 접근권한 설정 ######################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : 로그 파일의 권한중 타사용자에 쓰기권한이 부여되어 있지 않을 경우 양호" >> $CREATE_FILE 2>&1
echo "■ 현황 " >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
FILES="/var/adm/wtmpx /var/adm/utmpx /var/adm/wtmp /var/adm/utmp /var/log/syslog /var/adm/sulog /var/adm/pacct /var/log/authlog /var/adm/messages /var/adm/loginlog /var/adm/lastlog"

for file in $FILES; do
	if [ -f $file ]; then
		ls -al $file >> $CREATE_FILE 2>&1
	fi
done

echo " " > logfiles.txt

FILES="/var/adm/wtmpx /var/adm/utmpx /var/adm/wtmp /var/adm/utmp /var/log/syslog /var/adm/sulog /var/adm/pacct /var/log/authlog /var/adm/messages /var/adm/loginlog /var/adm/lastlog"

for file in $FILES; do
	if [ -f $file ]; then
		if [ `ls -al $file | awk '{print $1}' | grep '........w.' | wc -l` -gt 0 ]; then
			echo "● 2.13 결과 : 취약" >> logfiles.txt 2>&1
		else
			echo "● 2.13 결과 : 양호" >> logfiles.txt 2>&1
		fi
	else
		echo "로그 파일이 존재하지 않습니다." >> $CREATE_FILE 2>&1
		echo "● 2.13 결과 : 양호" >> logfiles.txt 2>&1
	fi
done

if [ `cat logfiles.txt | grep "취약" | wc -l` -eq 0 ]; then
	echo "로그 파일이 존재하지 않거나, 타 사용자에 쓰기 권한이 부여되어 있지 않습니다." >> $CREATE_FILE 2>&1
	echo " " >> $CREATE_FILE 2>&1
	echo "● 2.13 결과 : 양호" >> $CREATE_FILE 2>&1
else
	echo "● 2.13 결과 : 취약" >> $CREATE_FILE 2>&1
fi

rm -rf logfiles.txt
unset FILES

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "2.13 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su2_14() {
echo "2.14 START" >> $CREATE_FILE 2>&1
echo "############################ 2.접근통제 - 2.14 World Writable 파일 관리 ########################"
echo "############################ 2.접근통제 - 2.14 World Writable 파일 관리 ########################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : 주요 디렉터리(/sbin, /etc/, /bin, /usr/bin, /usr/sbin, /tmp)에 777권한 파일이 존재하지 않으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

if [ `ls -alR /sbin /etc /bin /usr/bin /usr/sbin /tmp |egrep "\-rwxrwxrwx" | wc -l` -eq 0 ]; then
	echo "주요 디렉터리에 777 권한의 파일이 존재하지 않습니다." >> $CREATE_FILE 2>&1
	echo "● 2.14 결과 : 양호" >> $CREATE_FILE 2>&1
 else
	ls -alR /sbin /etc /bin /usr/bin /usr/sbin /tmp |egrep "\-rwxrwxrwx" >> $CREATE_FILE 2>&1
	echo "● 2.14 결과 : 취약" >> $CREATE_FILE 2>&1
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "2.14 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}


su3_01() {
echo "3.01 START" >> $CREATE_FILE 2>&1
echo "############################ 3.시스템환경 설정 - 3.1 UMASK 설정 #############################################"
echo "############################ 3.시스템환경 설정 - 3.1 UMASK 설정 #############################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : UMASK 값이 022 또는 027이면 양호(UMASK값 필수, /etc/profile, /etc/default/login 중에 하나만 되어 있어도 양호)" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo "  " >> $CREATE_FILE 2>&1

echo "☞ UMASK 명령어  " >> $CREATE_FILE 2>&1
umask >> $CREATE_FILE 2>&1

echo "  " >> $CREATE_FILE 2>&1

echo "☞ /etc/profile 파일  " >> $CREATE_FILE 2>&1
if [ -f /etc/profile ]
 then
  if [ `cat /etc/profile | grep -i umask | wc -l` -gt 0  ]
    then
     cat /etc/profile | grep -i umask >> $CREATE_FILE 2>&1
    else
    echo "/etc/profile 파일에 설정값이 없습니다." >> $CREATE_FILE 2>&1
  fi
 else
   echo "/etc/profile 파일이 없습니다." >> $CREATE_FILE 2>&1
fi

echo "  " >> $CREATE_FILE 2>&1

echo "☞ /etc/default/login 파일  " >> $CREATE_FILE 2>&1
if [ -f /etc/default/login ]
 then
   cat /etc/default/login | grep -i umask | grep "=" >> $CREATE_FILE 2>&1
 else
   echo "/etc/default/login 파일이 없습니다." >> $CREATE_FILE 2>&1
fi

echo " " > mask.txt

if [ `umask` -ge 022  ]
  then
    echo "● 3.01 결과 : 양호" >> mask.txt
  else
    echo "● 3.01 결과 : 취약" >> mask.txt
fi


if [ -f /etc/profile ]
  then
   if [ `cat /etc/profile | grep -i "umask" |grep -v "#" | awk -F"0" '$2 >= "022"' | wc -l` -eq 1 ]
     then
       echo "● 3.01 결과 : 양호" >> mask.txt
     else
     if [ -f /etc/default/login ]
     then
       if [ `cat /etc/default/login | grep -i "umask" | grep -v "#" | awk -F"0" '$2 >= "022"' | wc -l` -eq 1 ]
        then
         echo "● 3.01 결과 : 양호" >> mask.txt
        else
         echo "● 3.01 결과 : 취약" >> mask.txt
       fi
     else
      echo "● 3.01 결과 : 취약" >> mask.txt
     fi
   fi
  else
   if [ -f /etc/default/login ]
   then
    if [ `cat /etc/default/login | grep -i "umask" | grep -v "#" | awk -F"0" '$2 >= "022"' | wc -l` -eq 1 ]
     then
      echo "● 3.01 결과 : 양호" >> mask.txt
     else
      echo "● 3.01 결과 : 취약" >> mask.txt
     fi
    else
     echo "● 3.01 결과 : 취약" >> mask.txt
   fi
fi

if [ `cat mask.txt | grep "취약" | wc -l` -eq 0 ]
 then
  echo "● 3.01 결과 : 양호" >> $CREATE_FILE 2>&1
 else
  echo "● 3.01 결과 : 취약" >> $CREATE_FILE 2>&1
fi

rm -rf mask.txt
echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "3.01 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su3_02() {
echo "3.02 START" >> $CREATE_FILE 2>&1
echo "############################ 3.시스템환경 설정 - 3.2 Setuid, Setgid 설정               #####################################"
echo "############################ 3.시스템환경 설정 - 3.2 Setuid, Setgid 설정               #####################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : Setuid, Setgid가 설정된 불필요한 파일이 존재하지 않으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

if [ `ls -al /usr/bin/admintool /usr/bin/at /usr/bin/atq /usr/bin/atrm /usr/bin/lpset /usr/bin/newgrp /usr/bin/nispasswd /usr/bin/rdist /usr/bin/yppasswd /usr/dt/bin/dtappgather /usr/dt/bin/dtprintinfo /usr/dt/bin/sdtcm_convert /usr/lib/fs/ufs/ufsdump /usr/lib/fs/ufs/ufsrestore /usr/lib/lp/bin/netpr /usr/openwin/bin/ff.core /usr/openwin/bin/kcms_calibrate /usr/openwin/bin/kcms_configure /usr/openwin/bin/xlock /usr/platform/sun4u/sbin/prtdiag /usr/sbin/arp /usr/sbin/lpmove /usr/sbin/prtconf |egrep ".rws......|....rws..." |wc -l` -eq 0 ]; then
	echo "불필요하게 setuid, setgid가 설정된 파일이 존재하지 않습니다." >> $CREATE_FILE 2>&1
    echo "● 3.02 결과 : 양호" >> $CREATE_FILE 2>&1
  else
    ls -al /usr/bin/admintool /usr/bin/at /usr/bin/atq /usr/bin/atrm /usr/bin/lpset /usr/bin/newgrp /usr/bin/nispasswd /usr/bin/rdist /usr/bin/yppasswd /usr/dt/bin/dtappgather /usr/dt/bin/dtprintinfo /usr/dt/bin/sdtcm_convert /usr/lib/fs/ufs/ufsdump /usr/lib/fs/ufs/ufsrestore /usr/lib/lp/bin/netpr /usr/openwin/bin/ff.core /usr/openwin/bin/kcms_calibrate /usr/openwin/bin/kcms_configure /usr/openwin/bin/xlock /usr/platform/sun4u/sbin/prtdiag /usr/sbin/arp /usr/sbin/lpmove /usr/sbin/prtconf |egrep ".rws......|....rws..." >> $CREATE_FILE 2>&1
    echo "● 3.02 결과 : 취약" >> $CREATE_FILE 2>&1
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "3.02 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su3_03() {
echo "3.03 START" >> $CREATE_FILE 2>&1
echo "############################ 3.시스템환경 설정 - 3.3 PATH(1) _ 현재 디렉터리(.) 설정 #####################################"
echo "############################ 3.시스템환경 설정 - 3.3 PATH(1) _ 현재 디렉터리(.) 설정 #####################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : 현재 위치를 의미하는 . 이 없거나, PATH 맨 뒤에 존재하면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo $PATH >> $CREATE_FILE 2>&1

if [ `echo $PATH | grep "\.:" | wc -l` -eq 0 ]
  then
    echo "● 3.03 결과 : 양호" >> $CREATE_FILE 2>&1
  else
    echo "● 3.03 결과 : 취약" >> $CREATE_FILE 2>&1
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "3.03 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su3_04() {
echo "3.04 START" >> $CREATE_FILE 2>&1
echo "############################ 3.시스템환경 설정 - 3.4 PATH(2) _ 존재하지 않는 디렉터리 설정 #####################################"
echo "############################ 3.시스템환경 설정 - 3.4 PATH(2) _ 존재하지 않는 디렉터리 설정 #####################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : PATH 환경변수에 설정된 디렉터리가 모두 존재하는 경우 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
    echo "☞  현재 PATH 설정내용" >> $CREATE_FILE 2>&1
    echo $PATH | awk 'BEGIN{FS=":"; OFS="\n"} {i=1; while(i<=NF) {print $i; i++}}' >> $CREATE_FILE 2>&1

    DIR=`echo $PATH | awk 'BEGIN{FS=":"; OFS="\n"} {i=1; while(i<=NF) {print $i; i++}}'`

    for check_dir in $DIR
    do
        if [ ! -d $check_dir ]
            then
                REGUL_SET=$REGUL_SET+$check_dir
        fi
    done

    echo " " >> $CREATE_FILE 2>&1

   echo "☞ 설정된 PATH에 존재하지 않는 디렉터리" >> $CREATE_FILE 2>&1
      FILES=`echo $REGUL_SET | awk 'BEGIN {FS="+"; OFS="\n"}{i=1; while(i<=NF) {print $i; i++}}'`
            for check_file in $FILES
            do
                echo $check_file >> $CREATE_FILE 2>&1
            done

    if [ "$REGUL_SET" != "" ]
        then
            echo "● 3.04 결과 : 취약" >> $CREATE_FILE 2>&1
        else         
            echo "● 3.04 결과 : 양호" >> $CREATE_FILE 2>&1
    fi

    unset DIR
    unset IMSI
    unset REGUL_SET

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "3.04 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su3_05() {
echo "3.05 START" >> $CREATE_FILE 2>&1
echo "############################ 3.시스템환경 설정 - 3.5 PATH(3) _ 디렉터리 소유자 및 접근권한 설정 #####################################"
echo "############################ 3.시스템환경 설정 - 3.5 PATH(3) _ 디렉터리 소유자 및 접근권한 설정 #####################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : PATH 환경변수에 설정된 디렉터리에서 다른사용자(other)의 쓰기권한이 없는경우 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
    echo "☞ 현재 PATH 설정내용" >> $CREATE_FILE 2>&1

    DIR=`echo $PATH | awk 'BEGIN{FS=":"; OFS="\n"} {i=1; while(i<=NF) {print $i; i++}}'`

    for check_dir in $DIR
    do
        if [ -d $check_dir ]
            then
                perm_check_dir $check_dir

                OWNER_PERM=`echo $PERM_FUNC_RESULT | awk '{print $1}'`
                GROUP_PERM=`echo $PERM_FUNC_RESULT | awk '{print $2}'`
                OTHER_PERM=`echo $PERM_FUNC_RESULT | awk '{print $3}'`
                RESULT_OWNER=`echo $PERM_FUNC_RESULT | awk '{print $4}'`

                echo `ls -ald $check_dir` >> $CREATE_FILE 2>&1

                if [ $OTHER_PERM -gt 5 ]
                    then
                    	
                    	# 이 부분은 주석함 (2007.12.26 by kbsps)
                    	## BIN 일경우 제외
                    	#if [ RESULT_OWNER != "bin" ]
                    	#	then
                       	#		REGUL_SET=$REGUL_SET+$check_dir
                       	#fi
                       	
                       	REGUL_SET=$REGUL_SET+$check_dir
                fi
        fi
    done

    if [ "$REGUL_SET" != "" ]
        then
            echo "●3.05 결과 : 취약" >> $CREATE_FILE 2>&1
       else
        echo "● 3.05 결과 : 양호" >> $CREATE_FILE 2>&1
    fi

    unset DIR
    unset OWNER_PERM
    unset GROUP_PERM
    unset OTHER_PERM
    unset RESULT_OWNER
    unset FILES
    unset REGUL_SET

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "3.05 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su3_06() {
echo "3.06 START" >> $CREATE_FILE 2>&1
echo "############################ 3.시스템 환경설정 - 3.6 Session Timeout 설정 #############################"
echo "############################ 3.시스템 환경설정 - 3.6 Session Timeout 설정 #############################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : /etc/default/login 파일에서 TIMEOUT 이 300으로 설정되어 있으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "☞ /etc/default/login 파일설정" >> $CREATE_FILE 2>&1
if [ -f /etc/default/login ]
 then
    cat /etc/default/login | grep -i 'TIMEOUT' >> $CREATE_FILE 2>&1
 else
  echo "/etc/default/login 파일이 없습니다." >> $CREATE_FILE 2>&1
fi

if [ -f /etc/default/login ]
 then
  if [ `cat /etc/default/login | grep -v "#" | grep 'TIMEOUT' | grep -v '[0-9]300' | grep '300$' | wc -l` -eq 1 ]
      then
       echo "● 3.06 결과 : 양호" >> $CREATE_FILE 2>&1
      else
       echo "● 3.06 결과 : 취약" >> $CREATE_FILE 2>&1
  fi
 else
  echo "● 3.06 결과 : 취약" >> $CREATE_FILE 2>&1
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "3.06 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su4_01() {
echo "4.01 START" >> $CREATE_FILE 2>&1
echo "############################ 4.네트워크 서비스 - 4.1 서비스 배너 관리 ###############################"
echo "############################ 4.네트워크 서비스 - 4.1 서비스 배너 관리 ###############################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : Telnet, FTP, SMTP, DNS 가 구동중이지 않거나 배너에 O/S 및 버전 정보가 없을 경우" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "  " > banner.txt
echo " " > banner_temp.txt

if [ $SOL_VERSION = "1" ]
 then
ps -ef | grep inetd  | grep -v grep >> inetd.txt
ps -ef | grep telnetd  | grep -v grep >> telnetps.txt

if [ `cat inetd.txt | grep inetd | grep -v grep | wc -l` -gt 0 ]
 then
 cat /etc/inetd.conf | grep 'telnetd' | grep -v '#' >> telnetps.txt
fi

if [ `cat telnetps.txt | grep telnetd | grep -v grep | wc -l` -gt 0 ]
 then
     echo "☞ Telnet 서비스 구동중입니다." >> $CREATE_FILE 2>&1
     echo "■ TELNET 배너" >> $CREATE_FILE 2>&1
   if [ -f /etc/default/telnetd ]
    then
     if [ `cat /etc/default/telnetd | grep -i "banner" | wc -l` -eq 0 ]
      then
        echo "● 4.01 결과 : 취약" >> banner.txt
        echo "/etc/default/telnetd 파일 설정 없습니다." >> $CREATE_FILE 2>&1
      else
        echo "● 4.01 결과 : 양호" >> banner.txt
        echo "/etc/default/telnetd 파일 내용" >> $CREATE_FILE 2>&1
        cat /etc/default/telnetd | grep -i "banner" >> $CREATE_FILE 2>&1
     fi
    else
     echo "● 4.01 결과 : 취약" >> banner.txt
     echo "/etc/default/telnetd 파일 존재하지 않습니다." >> $CREATE_FILE 2>&1
   fi
 else
  echo "● 4.01 결과 : 양호" >> banner.txt
  echo "☞ Telnet 서비스 비실행중입니다." >> $CREATE_FILE 2>&1
fi
else
  if [ `inetadm | grep "online" | egrep 'telnet' | wc -l` -gt 0 ]
     then
     echo "☞ Telnet 서비스 구동중입니다." >> $CREATE_FILE 2>&1
     echo "■ TELNET 배너" >> $CREATE_FILE 2>&1
       if [ -f /etc/default/telnetd ]
          then
            if [ `cat /etc/default/telnetd | grep -i "banner" | wc -l` -eq 0 ]
               then
                 echo "● 4.01 결과 : 취약" >> banner.txt
                 echo "/etc/default/telnetd 파일 설정 없습니다." >> $CREATE_FILE 2>&1
                else
                echo "● 4.01 결과 : 양호" >> banner.txt
                echo "/etc/default/telnetd 파일 내용" >> $CREATE_FILE 2>&1
                cat /etc/default/telnetd | grep -i "banner" >> $CREATE_FILE 2>&1
           fi
           else
                echo "● 4.01 결과 : 취약" >> banner.txt
                echo "/etc/default/telnetd 파일 존재하지 않습니다." >> $CREATE_FILE 2>&1
      fi
  else
  echo "● 4.01 결과 : 양호" >> banner.txt
  echo "☞ Telnet 서비스 비실행중입니다." >> $CREATE_FILE 2>&1
  fi
fi

echo "  " >> $CREATE_FILE 2>&1

if [ $SOL_VERSION = "1" ]
 then

ps -ef | grep ftpd | grep -v grep >> ftpps.txt

if [ `cat inetd.txt | grep inetd | grep -v grep | wc -l` -gt 0 ]
 then
   cat /etc/inetd.conf | grep 'ftpd' | grep -v '#' >> ftpps.txt
fi

if [ `cat ftpps.txt | grep ftpd | grep -v grep | wc -l` -gt 0 ]
 then
     echo "☞ FTP 서비스 구동중입니다." >> $CREATE_FILE 2>&1
     echo "■ FTP 배너" >> $CREATE_FILE 2>&1
  if [ -f /etc/default/ftpd ]
    then
     if [ `cat /etc/default/ftpd | grep -i "banner" | wc -l` -eq 0 ]
      then
        echo "● 4.01 결과 : 취약" >> banner.txt
        echo "/etc/default/ftpd 파일 설정 없습니다." >> $CREATE_FILE 2>&1
      else
        echo "● 4.01 결과 : 양호" >> banner.txt
        echo "/etc/default/ftpd 파일 내용" >> $CREATE_FILE 2>&1
        cat /etc/default/ftpd | grep -i "banner" >> $CREATE_FILE 2>&1
     fi
    else
     echo "● 4.01 결과 : 취약" >> banner.txt
     echo "/etc/default/ftpd 파일 존재하지 않습니다." >> $CREATE_FILE 2>&1
   fi
 else
  echo "● 4.01 결과 : 양호" >> banner.txt
  echo "☞ FTP 서비스 비실행중입니다." >> $CREATE_FILE 2>&1
fi
else
  if [ `inetadm | grep "online" | egrep 'ftp' | wc -l` -gt 0 ]
     then
       echo "☞ FTP 서비스 구동중입니다." >> $CREATE_FILE 2>&1
       echo "■ FTP 배너" >> $CREATE_FILE 2>&1
         if [ -f /etc/default/ftpd ]
            then
               if [ `cat /etc/default/ftpd | grep -i "banner" | wc -l` -eq 0 ]
                  then
                    echo "● 4.01 결과 : 취약" >> banner.txt
                    echo "/etc/default/ftpd 파일 설정 없습니다." >> $CREATE_FILE 2>&1
                  else
                    echo "● 4.01 결과 : 양호" >> banner.txt
                    echo "/etc/default/ftpd 파일 내용" >> $CREATE_FILE 2>&1
                   cat /etc/default/ftpd | grep -i "banner" >> $CREATE_FILE 2>&1
              fi
             else
                 echo "● 4.01 결과 : 취약" >> banner.txt
                echo "/etc/default/ftpd 파일 존재하지 않습니다." >> $CREATE_FILE 2>&1
         fi
     else
        echo "● 4.01 결과 : 양호" >> banner.txt
        echo "☞ FTP 서비스 비실행중입니다." >> $CREATE_FILE 2>&1
  fi
fi

echo " " > banner_temp.txt
echo "  " >> $CREATE_FILE 2>&1

if [ `ps -ef | grep sendmail | grep -v grep | wc -l` -gt 0 ]
 then
     echo "☞ SMTP 서비스 구동중입니다." >> $CREATE_FILE 2>&1
     echo "■ SMTP 배너" >> $CREATE_FILE 2>&1
   if [ -f /etc/mail/sendmail.cf ]
     then
       if [ `cat /etc/mail/sendmail.cf | grep -i "GreetingMessage" | grep -i "Sendmail" | wc -l` -gt 0 ]
         then
           echo "● 4.01 결과 : 취약" >> banner.txt
           echo "/etc/mail/sendmail.cf 파일 내용 " >> $CREATE_FILE 2>&1
           cat /etc/mail/sendmail.cf | grep -i "GreetingMessage" >> $CREATE_FILE 2>&1
         else
           echo "● 4.01 결과 : 양호" >> banner.txt
           echo "/etc/mail/sendmail.cf 파일 내용" >> $CREATE_FILE 2>&1
           cat /etc/mail/sendmail.cf | grep -i "GreetingMessage" >> $CREATE_FILE 2>&1
       fi
     else
       echo "● 4.01 결과 : 수동" >> banner.txt
       echo "/etc/mail/sendmail.cf 파일 존재하지 않습니다. 다른경로를 점검해야 합니다." >> $CREATE_FILE 2>&1
   fi
 else
  echo "● 4.01 결과 : 양호" >> banner.txt
  echo "☞ SMTP 서비스 비실행중입니다." >> $CREATE_FILE 2>&1
fi

echo "  " >> $CREATE_FILE 2>&1

if [ `ps -ef | grep named | grep -v grep | wc -l` -gt 0 ]
  then
     echo "☞ DNS 서비스 구동중입니다." >> $CREATE_FILE 2>&1
     echo "■ DNS 배너" >> $CREATE_FILE 2>&1
    if [ -f /etc/named.conf ]
      then
        if [ `cat /etc/named.conf | grep "version" | wc -l` -eq 0 ]
          then
            echo "● 4.01 결과 : 취약" >> banner.txt
           echo "/etc/named.conf 파일 내용" >> $CREATE_FILE 2>&1
           echo "/etc/named.conf 파일 설정 없습니다." >> $CREATE_FILE 2>&1
         else
           echo "● 4.01 결과 : 양호" >> banner.txt
           echo "/etc/named.conf 파일 내용" >> $CREATE_FILE 2>&1
           cat /etc/named.conf | grep -i "version" >> $CREATE_FILE 2>&1
       fi
     else
       echo "● 4.01 결과 : 수동" >> banner.txt
       echo "/etc/named.conf 파일 존재하지 않습니다. 다른경로를 점검해야 합니다." >> $CREATE_FILE 2>&1
   fi
 else
  echo "● 4.01 결과 : 양호" >> banner.txt
  echo "☞ DNS 서비스 비실행중입니다." >> $CREATE_FILE 2>&1
fi

if [ `cat banner.txt | grep "취약" | wc -l` -eq 0 ]
 then
  echo "● 4.01 결과 : 양호" >> $CREATE_FILE 2>&1
 else
  echo "● 4.01 결과 : 취약" >> $CREATE_FILE 2>&1
fi

if [ `cat banner.txt | grep "수동" | wc -l` -gt 0 ]
 then
  echo "● 4.01 결과 : 수동" >> $CREATE_FILE 2>&1
 fi

rm -rf banner.txt inetd.txt
rm -rf banner_temp.txt
rm -rf ftpps.txt telnetps.txt
echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "4.01 END" >> $CREATE_FILE 2>&1
echo "  " >> $CREATE_FILE 2>&1
}

su4_02() {
echo "4.02 START" >> $CREATE_FILE 2>&1
echo "############################ 4.네트워크 서비스 - 4.2 RPC 서비스 ###################################"
echo "############################ 4.네트워크 서비스 - 4.2 RPC 서비스 ###################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : 불필요한 rpc 관련 서비스가 존재하지 않으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

if [ $SOL_VERSION = "1" ]
 then
 SERVICE_INETD="rpc.cmsd|rpc.ttdbserverd|sadmind|rusersd|walld|sprayd|rstatd|rpc.nisd|rpc.pcnfsd|rpc.statd|rpc.ypupdated|rpc.rquotad|kcms_server|cachefsd|rexd"
   if [ `cat /etc/inetd.conf | grep -v '^ *#' | egrep $SERVICE_INETD | wc -l` -gt 0 ]
     then
      cat /etc/inetd.conf | grep -v '^ *#' | egrep $SERVICE_INETD >> $CREATE_FILE 2>&1
      else
      echo "불필요한 RPC 서비스가 존재하지 않습니다." >> $CREATE_FILE 2>&1
   fi

  if [ -f /etc/inetd.conf ]
     then
        if [ `cat /etc/inetd.conf | grep -v '^ *#' | egrep $SERVICE_INETD | wc -l` -eq 0 ]
              then
                 echo "● 4.02 결과 : 양호" >> $CREATE_FILE 2>&1
              else
                 echo "● 4.02 결과 : 취약"  >> $CREATE_FILE 2>&1
        fi
      else
           echo "● 4.02 결과 : 양호" >> $CREATE_FILE 2>&1
  fi
else
  if [ `inetadm | grep "online" | egrep 'cms|ttdbserver|sadmin|rusers|wall|spray|rstat|nis|pcnfs|stat|ypupdate|rquota|kcms_server|cachefs|rex' | grep -v 'rexec' | wc -l` -eq 0 ]
     then
        echo "불필요한 RPC 서비스가 존재하지 않습니다." >> $CREATE_FILE 2>&1
     else
        inetadm | grep "online" | egrep 'cms|ttdbserver|sadmin|rusers|wall|spray|rstat|nis|pcnfs|stat|ypupdate|rquota|kcms_server|cachefs|rex' | grep -v 'rexec' >> $CREATE_FILE 2>&1
   fi
echo " " >> $CREATE_FILE 2>&1

  if [ `inetadm | grep "online" | egrep 'cms|ttdbserver|sadmin|rusers|wall|spray|rstat|nis|pcnfs|stat|ypupdate|rquota|kcms_server|cachefs|rex' | grep -v 'rexec' | wc -l` -eq 0 ]
     then
        echo "● 4.02 결과 : 양호" >> $CREATE_FILE 2>&1
     else
        echo "● 4.02 결과 : 취약"  >> $CREATE_FILE 2>&1
  fi
fi

unset SERVICE_INETD
echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "4.02 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}


su4_03() {
echo "4.03 START" >> $CREATE_FILE 2>&1
echo "############################ 4.네트워크 서비스 - 4.3 R 서비스 _ 신뢰 관계 설정 #####################################"
echo "############################ 4.네트워크 서비스 - 4.3 R 서비스 _ 신뢰 관계 설정 #####################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : r 서비스를 사용하지 않거나,  + 가 설정되어 있지 않으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

r_service_flag=0
vul_flag=0

echo "☞ R 서비스 구동 진단" >> $CREATE_FILE 2>&1
if [ $SOL_VERSION = "1" ]; then
	SERVICE_INETD="^shell|^login|^exec"
	if [ -f /etc/inetd.conf ]; then
		if [ `cat /etc/inetd.conf | grep -v '^ *#' | egrep $SERVICE_INETD | wc -l ` -gt 0 ]; then
			cat /etc/inetd.conf | grep -v '^#' | egrep $SERVICE_INETD >> $CREATE_FILE 2>&1
			r_service_flag=1
		fi
	else
		echo "r 서비스가 비활성화 되어 있습니다." >> $CREATE_FILE 2>&1
	fi
else
	if [ `inetadm | egrep 'login|shell|rexec' | egrep -v  'klogin|kshell|kexec' | grep 'online' | wc -l` -eq 0 ]; then
		echo "r 서비스가 비활성화 되어 있습니다."  >> $CREATE_FILE 2>&1
	else
		inetadm | egrep 'login|shell|rexec' | egrep -v  'klogin|kshell|kexec' | grep 'online'  >> $CREATE_FILE 2>&1
		r_service_flag=1
	fi
fi

echo " " >> $CREATE_FILE 2>&1

HOMEDIRS=`cat /etc/passwd | awk -F":" 'length($6) > 0 {print $6}' | sort -u`
FILES="/.rhosts"

if [ $r_service_flag -eq 1 ]; then
	echo "☞ R 서비스 신뢰관계 진단" >> $CREATE_FILE 2>&1
	if [ -f /etc/hosts.equiv ]; then
		echo "① /etc/hosts.equiv 파일 설정 내용" >> $CREATE_FILE 2>&1
		cat /etc/hosts.equiv >> $CREATE_FILE 2>&1
		if [ `cat /etc/hosts.equiv | grep "+" | grep -v "grep" | grep -v "#" | wc -l ` -ne 0 ]; then
			vul_flag=1
		fi
	else
		echo "① /etc/hosts.equiv 파일 설정 내용" >> $CREATE_FILE 2>&1
		echo "해당 파일 없습니다." >> $CREATE_FILE 2>&1
	fi
	echo " " >> $CREATE_FILE 2>&1

	echo "② 사용자 home directory .rhosts 설정 내용" >> $CREATE_FILE 2>&1

	for dir in $HOMEDIRS; do
		for file in $FILES; do
			if [ -f $dir$file ]; then
				ls -al $dir$file  >> $CREATE_FILE 2>&1
				echo "- $dir$file 설정 내용" >> $CREATE_FILE 2>&1
				cat $dir$file | grep -v "#" >> $CREATE_FILE 2>&1
				echo " " >> $CREATE_FILE 2>&1
				if [ `cat $dir$file | grep "+" | grep -v "grep" | grep -v "#" |wc -l ` -ne 0 ]; then
				  vul_flag=1
				fi
			fi
		done
	done
fi

if [ $vul_flag -eq 0 ]; then
	echo "● 4.03 결과 : 양호" >> $CREATE_FILE 2>&1
else
	echo "● 4.03 결과 : 취약" >> $CREATE_FILE 2>&1
fi

unset HOMEDIRS
unset FILES

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "4.03 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su4_04() {
echo "4.04 START" >> $CREATE_FILE 2>&1
echo "############################ 4.네트워크 서비스 - 4.4 NFS(1) _ 공유 설정  #########################################"
echo "############################ 4.네트워크 서비스 - 4.4 NFS(1) _ 공유 설정  #########################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : NFS가 중지되어 있거나 NFS 설정파일에 Everyone 공유가 없을 경우에 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

if [ $SOL_VERSION = "1" ]
   then
     echo "☞ NFS 데몬(nfsd)확인" >> $CREATE_FILE 2>&1
     ps -ef | grep "nfsd" | egrep -v "grep|statdaemon|automountd" | grep -v "grep" >> $CREATE_FILE 2>&1
     echo " " >> $CREATE_FILE 2>&1
     ls -al /etc/rc*.d/* | grep -i nfs | grep "/S" >> $CREATE_FILE 2>&1
    echo " " >> $CREATE_FILE 2>&1
         if [ `ps -ef | grep "nfsd" | egrep -v "grep|statdaemon|automountd" | grep -v "grep" | wc -l` -gt 0 ]
            then
              if [ -f /etc/exports ]
                then
                  cat /etc/exports  >> $CREATE_FILE 2>&1
                else
                  echo "/etc/exports 파일이 존재하지 않습니다."  >> $CREATE_FILE 2>&1
              fi
            else
          echo "NFS 서비스가 비실행중입니다." >> $CREATE_FILE 2>&1
         fi


    if [ `ps -ef | egrep "nfsd" | egrep -v "grep|statdaemon|automountd" | grep -v "grep" | wc -l` -eq 0 ]
       then
         echo "● 4.04 결과 : 양호" >> $CREATE_FILE 2>&1
       else
       if [ -f /etc/exports ]
          then
           if [ `cat /etc/exports | grep -v "#" | grep "/" | wc -l` -eq 0 ]
               then
                 echo "● 4.04 결과 : 양호" >> $CREATE_FILE 2>&1
               else
                 echo "● 4.04 결과 : 수동" >> $CREATE_FILE 2>&1
           fi
          else
           echo "● 4.04 결과 : 양호"  >> $CREATE_FILE 2>&1
      fi
   fi
else
  echo "☞ NFS 데몬(nfsd)확인" >> $CREATE_FILE 2>&1
  echo " " >> $CREATE_FILE 2>&1
  svcs -a | grep "nfs/server" | grep "online" >> $CREATE_FILE 2>&1
  echo " " >> $CREATE_FILE 2>&1
  ls -al /etc/rc*.d/* | grep -i nfs | grep "/S" >> $CREATE_FILE 2>&1
  echo " " >> $CREATE_FILE 2>&1

     if [ `svcs -a | grep "nfs/server" | grep "online" | wc -l` -eq 0 ]
        then
          echo "NFS 서비스가 비실행중입니다" >> $CREATE_FILE 2>&1
        else
          svcs -a | grep "nfs/server" | grep "online" >> $CREATE_FILE 2>&1
          echo " " >> $CREATE_FILE 2>&1
          cat /etc/dfs/dfstab >> $CREATE_FILE 2>&1
     fi


    if [ `svcs -a | grep "nfs/server" | grep "online" | wc -l` -eq 0 ]
        then
          echo "● 4.04 결과 : 양호" >> $CREATE_FILE 2>&1
        else
          if [ -f /etc/dfs/dfstab ]
             then
                if [ `cat /etc/dfs/dfstab | grep -v "#" | grep "/" | wc -l` -eq 0 ]
                   then
                     echo "● 4.04 결과 : 양호" >> $CREATE_FILE 2>&1
                   else
                     echo "● 4.04 결과 : 수동" >> $CREATE_FILE 2>&1
               fi
             else
                echo "● 4.04 결과 : 양호"  >> $CREATE_FILE 2>&1
         fi
    fi
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "4.04 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su4_05(){
echo "4.05 START" >> $CREATE_FILE 2>&1
echo "############################ 4.네트워크 서비스 - 4.5 NFS(2) _ 원격 마운트 설정 ###########################"
echo "############################ 4.네트워크 서비스 - 4.5 NFS(2) _ 원격 마운트 설정 ###########################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : NFS 서비스가 비실행중이거나 showmount값이 없으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

if [ $SOL_VERSION = "1" ]
 then
    ps -ef | grep "nfsd" | grep -v "grep" >> $CREATE_FILE 2>&1
   echo " " >> $CREATE_FILE 2>&1
      if [ `ps -ef | grep nfsd | grep -v "grep" | wc -l` -gt 0 ]
         then
           echo "☞ NFS를 원격에서 mount하고 있는 시스템을 확인 " >> $CREATE_FILE 2>&1
           showmount  >> $CREATE_FILE 2>&1
         else
           echo "NFS 서비스가 비실행중입니다. " >> $CREATE_FILE 2>&1
      fi
echo " " >> $CREATE_FILE 2>&1

     if [ `ps -ef | grep nfsd | grep -v "grep" | wc -l` -eq 0 ]
         then
            echo "● 4.05 결과 : 양호" >> $CREATE_FILE 2>&1
         else
            echo "● 4.05 결과 : 수동" >> $CREATE_FILE 2>&1
     fi
else
   svcs -a | grep "nfs/server" | grep "online" >> $CREATE_FILE 2>&1
   echo " " >> $CREATE_FILE 2>&1
     if [ `svcs -a | grep "nfs/server" | grep "online" | wc -l` -eq 0 ]
       then
         echo "NFS 서비스가 비실행중입니다" >> $CREATE_FILE 2>&1
       else
          if [ `showmount | egrep -v "Program not registered|프로그램이 등록되지 않음" | wc -l` -eq 0 ]
             then
                echo "NFS 서비스가 비실행중입니다. " >> $CREATE_FILE 2>&1
             else
                showmount >> $CREATE_FILE 2>&1
          fi
     fi
echo " " >> $CREATE_FILE 2>&1

    if [ `svcs -a | grep "nfs/server" | grep "online" | wc -l` -eq 0 ]
       then
         echo "● 4.05 결과 : 양호" >> $CREATE_FILE 2>&1
       else
         echo "● 4.05 결과 : 수동" >> $CREATE_FILE 2>&1
    fi
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "4.05 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su4_06() {
echo "4.06 START" >> $CREATE_FILE 2>&1
echo "############################ 4.네트워크 서비스 - 4.6 NFS(3) _ statd, lockd, automountd 제거  ################################"
echo "############################ 4.네트워크 서비스 - 4.6 NFS(3) _ statd, lockd, automountd 제거 ################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : statd, lockd, automountd 서비스가 구동중이지 않을 경우 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

if [ $SOL_VERSION = "1" ]
 then
    echo "☞ statd, lockd, Automount 데몬 확인" >> $CREATE_FILE 2>&1
    ps -ef | egrep "statd|lockd|automountd|autofs" | egrep -v "grep|statdaemon|emi|kblockd" | grep -v "grep" >> $CREATE_FILE 2>&1
    echo " " >> $CREATE_FILE 2>&1
    ls -al /etc/rc*.d/* | grep -i nfs | grep "/S" >> $CREATE_FILE 2>&1
    ls -al /etc/rc*.d/* | grep -i auto | grep "/S" >> $CREATE_FILE 2>&1
    echo " " >> $CREATE_FILE 2>&1

      if [ `ps -ef | egrep "statd|lockd|automountd|autofs" | egrep -v "grep|statdaemon|emi|kblockd" | wc -l` -eq 0 ]
         then
           echo "statd, lockd, automount 데몬이 없습니다. " >> $CREATE_FILE 2>&1
      fi


      if [ `ps -ef | egrep "statd|lockd|automountd|autofs" | egrep -v "grep|statdaemon|emi|kblockd" | wc -l` -eq 0 ]
         then
           echo "● 4.06 결과 : 양호" >> $CREATE_FILE 2>&1
         else
           echo "● 4.06 결과 : 취약" >> $CREATE_FILE 2>&1
      fi
else
echo "☞ statd, lockd, Automount 데몬 확인" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
svcs -a | egrep 'status|nlockmgr|automount|autofs'  | grep "online" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
ls -al /etc/rc*.d/* | grep -i nfs | grep "/S" >> $CREATE_FILE 2>&1
ls -al /etc/rc*.d/* | grep -i auto | grep "/S" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

     if [ `svcs -a | egrep 'status|nlockmgr|automount|autofs'  | grep "online" | wc -l` -eq 0 ]
        then
         echo "statd, lockd, automount 데몬이 없습니다." >> $CREATE_FILE 2>&1
     fi


     if [ `svcs -a | egrep 'status|nlockmgr|automount|autofs'  | grep "online" | wc -l` -gt 0 ]
        then
           echo "● 4.06 결과 : 취약" >> $CREATE_FILE 2>&1
        else
           echo "● 4.06 결과 : 양호" >> $CREATE_FILE 2>&1
     fi
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "4.06 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su4_07() {
echo "4.07 START" >> $CREATE_FILE 2>&1
echo "############################ 4.네트워크 서비스 - 4.7 FTP(1) _ 사용자 제한 ###########################"
echo "############################ 4.네트워크 서비스 - 4.7 FTP(1) _ 사용자 제한 ###########################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : ftp 를 사용하지 않거나 ftp 사용시 ftpusers 파일에 root 가 있을 경우 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

if [ $SOL_VERSION = "1" ]
 then
ps -ef | grep inetd  | grep -v grep >> inetd.txt
ps -ef | grep ftpd | grep -v grep >> ftpps.txt

if [ `cat inetd.txt | grep inetd | grep -v grep | wc -l` -gt 0 ]
 then
   cat /etc/inetd.conf | grep 'ftpd' | grep -v '#' >> ftpps.txt
fi

if [ `cat ftpps.txt | grep ftpd | grep -v grep | wc -l` -gt 0 ]
  then
    if [ -f /etc/ftpd/ftpusers ]
      then
        cat /etc/ftpd/ftpusers  >> $CREATE_FILE 2>&1
      else
        echo "/etc/ftpd/ftpusers  파일이 없습니다." >> $CREATE_FILE 2>&1
    fi

    echo " " >> $CREATE_FILE 2>&1

    if [ -f /etc/ftpusers ]
      then
        cat /etc/ftpusers  >> $CREATE_FILE 2>&1
      else
        echo "/etc/ftpusers  파일이 없습니다." >> $CREATE_FILE 2>&1
    fi
  else
    echo "☞ ftp 서비스 비 실행중입니다." >> $CREATE_FILE 2>&1
fi




if [ `cat ftpps.txt | grep ftpd | grep -v grep | wc -l` -gt 0 ]
  then
   if [ -f /etc/ftpd/ftpusers ]
    then
      if [ `cat /etc/ftpd/ftpusers | grep root | grep -v "#" | wc -l` -eq 1 ]
          then
           echo "● 4.07 결과 : 양호" >> $CREATE_FILE 2>&1
          else
          if [ -f /etc/ftpusers ]
           then
            if [ `cat /etc/ftpusers | grep root | grep -v "#" | wc -l` -eq 1 ]
             then
              echo "● 4.07 결과 : 양호" >> $CREATE_FILE 2>&1
             else
              echo "● 4.07 결과 : 취약" >> $CREATE_FILE 2>&1
            fi
           else
            echo "● 4.07 결과 : 취약" >> $CREATE_FILE 2>&1
          fi
     fi
else
     if [ -f /etc/ftpusers ]
         then
            if [ `cat /etc/ftpusers | grep root | grep -v "#" | wc -l` -eq 1 ]
             then
              echo "● 4.07 결과 : 양호" >> $CREATE_FILE 2>&1
             else
              echo "● 4.07 결과 : 취약" >> $CREATE_FILE 2>&1
            fi
         else
           echo "● 4.07 결과 : 취약" >> $CREATE_FILE 2>&1
     fi
fi
else
  echo "● 4.07 결과 : 양호" >> $CREATE_FILE 2>&1
fi
else
if [ `inetadm | grep "online" | egrep 'ftp' | wc -l` -gt 0 ]
 then
    if [ -f /etc/ftpd/ftpusers ]
      then
        cat /etc/ftpd/ftpusers  >> $CREATE_FILE 2>&1
      else
        echo "/etc/ftpd/ftpusers  파일이 없습니다." >> $CREATE_FILE 2>&1
    fi

    echo " " >> $CREATE_FILE 2>&1

    if [ -f /etc/ftpusers ]
      then
        cat /etc/ftpusers  >> $CREATE_FILE 2>&1
      else
        echo "/etc/ftpusers  파일이 없습니다." >> $CREATE_FILE 2>&1
    fi
  else
    echo "☞ ftp 서비스 비 실행중입니다." >> $CREATE_FILE 2>&1
fi



if [ `inetadm | grep "online" | egrep 'ftp' | wc -l` -gt 0 ]
  then
   if [ -f /etc/ftpd/ftpusers ]
    then
      if [ `cat /etc/ftpd/ftpusers | grep root | grep -v "#" | wc -l` -eq 1 ]
          then
           echo "● 4.07 결과 : 양호" >> $CREATE_FILE 2>&1
          else
          if [ -f /etc/ftpusers ]
           then
            if [ `cat /etc/ftpusers | grep root | grep -v "#" | wc -l` -eq 1 ]
             then
              echo "● 4.07 결과 : 양호" >> $CREATE_FILE 2>&1
             else
              echo "● 4.07 결과 : 취약" >> $CREATE_FILE 2>&1
            fi
           else
            echo "● 4.07 결과 : 취약" >> $CREATE_FILE 2>&1
          fi
     fi
else
     if [ -f /etc/ftpusers ]
         then
            if [ `cat /etc/ftpusers | grep root | grep -v "#" | wc -l` -eq 1 ]
             then
              echo "● 4.07 결과 : 양호" >> $CREATE_FILE 2>&1
             else
              echo "● 4.07 결과 : 취약" >> $CREATE_FILE 2>&1
            fi
         else
           echo "● 4.07 결과 : 취약" >> $CREATE_FILE 2>&1
     fi
fi
else
  echo "● 4.07 결과 : 양호" >> $CREATE_FILE 2>&1
fi
fi

rm -rf ftpps.txt
rm -rf inetd.txt
echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "4.07 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su4_08() {
echo "4.08 START" >> $CREATE_FILE 2>&1
echo "############################ 4.네트워크 서비스 - 4.8 FTP(2) _ Anonymous 제한 ###############################"
echo "############################ 4.네트워크 서비스 - 4.8 FTP(2) _ Anonymous 제한 ###############################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : ftp 를 사용하지 않거나, ftp 사용시 /etc/passwd 파일에 ftp 계정이 존재하지 않을 경우 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

if [ $SOL_VERSION = "1" ]
 then

ps -ef | grep inetd  | grep -v grep >> inetd.txt
ps -ef | grep ftpd | grep -v grep >> ftpps.txt

if [ `cat inetd.txt | grep inetd | grep -v grep | wc -l` -gt 0 ]
 then
   cat /etc/inetd.conf | grep 'ftpd' | grep -v '#' >> ftpps.txt
fi

if [ `cat ftpps.txt | grep ftpd | grep -v grep | wc -l` -gt 0 ]
  then
    if [ -f /etc/passwd ]
    then
       cat /etc/passwd | grep "ftp" >> $CREATE_FILE 2>&1
    else
       echo "/etc/passwd 파일이 없습니다. " >> $CREATE_FILE 2>&1
    fi
  else
  echo "ftp 서비스가 비실행중입니다. " >> $CREATE_FILE 2>&1
fi



if [ `cat ftpps.txt | grep ftpd | grep -v grep | wc -l` -gt 0 ]
then
 if [ `grep -v "^ *#" /etc/passwd | grep "ftp" | wc -l` -gt 0 ]
 then
   echo "● 4.08 결과 : 취약" >> $CREATE_FILE 2>&1
 else
   echo "● 4.08 결과 : 양호" >> $CREATE_FILE 2>&1
 fi
else
        echo "● 4.08 결과 : 양호" >> $CREATE_FILE 2>&1
fi
else
if [ `inetadm | grep "online" | egrep 'ftp' | wc -l` -gt 0 ]
  then
    if [ -f /etc/passwd ]
    then
       cat /etc/passwd | grep "ftp" >> $CREATE_FILE 2>&1
    else
       echo "/etc/passwd 파일이 없습니다. " >> $CREATE_FILE 2>&1
    fi
  else
  echo "ftp 서비스가 비실행중입니다. " >> $CREATE_FILE 2>&1
fi



if [ `inetadm | grep "online" | egrep 'ftp' | wc -l` -gt 0 ]
then
 if [ `grep -v "^ *#" /etc/passwd | grep "ftp" | wc -l` -gt 0 ]
 then
   echo "● 4.08 결과 : 취약" >> $CREATE_FILE 2>&1
 else
   echo "● 4.08 결과 : 양호" >> $CREATE_FILE 2>&1
 fi
else
        echo "● 4.08 결과 : 양호" >> $CREATE_FILE 2>&1
fi
fi
rm -rf ftpps.txt
rm -rf inetd.txt

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "4.08 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su4_09() {
echo "4.09 START" >> $CREATE_FILE 2>&1
echo "############################ 4.네트워크 서비스 - 4.9 FTP(3) _ umask 설정 ###################################"
echo "############################ 4.네트워크 서비스 - 4.9 FTP(3) _ umask 설정###################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : ftp 를 사용하지 않거나, ftp 사용시 ftp umask 가 077 로 설정되어 있을 경우 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

# Solaris 9 이하
if [ $SOL_VERSION = "1" ]; then
	ps -ef | grep inetd  | grep -v grep >> inetd.txt
	ps -ef | grep ftpd | grep -v grep >> ftpps.txt

	if [ `cat inetd.txt | grep inetd | grep -v grep | wc -l` -gt 0 ]; then
	   cat /etc/inetd.conf | grep 'ftpd' | grep -v '#' | grep -v "tftp" >> ftpps.txt
	fi

	if [ `cat ftpps.txt | grep ftpd | grep -v grep | wc -l` -gt 0 ]; then
		if [ -f /etc/default/ftpd ]; then
			echo "☞/etc/default/ftpd 파일" >> $CREATE_FILE 2>&1
			cat /etc/default/ftpd >> $CREATE_FILE 2>&1
			echo " " >> $CREATE_FILE 2>&1
		 else
			echo "☞ /etc/default/ftpd 파일" >> $CREATE_FILE 2>&1
			echo "/etc/default/ftpd  파일 없습니다." >> $CREATE_FILE 2>&1
			echo " " >> $CREATE_FILE 2>&1
		fi

		if [ -f /etc/inetd.conf ]; then
			echo "☞ /etc/inetd.conf 파일" >> $CREATE_FILE 2>&1
			cat /etc/inetd.conf | grep 'ftpd' | grep -v '#' | grep -v "tftp" >> $CREATE_FILE 2>&1
		else
			echo "☞ /etc/inetd.conf 파일" >> $CREATE_FILE 2>&1
			echo "/etc/inetd.conf  파일이 없습니다." >> $CREATE_FILE 2>&1
		fi
	else
		echo "☞ ftp 서비스 비 실행중입니다. " >> $CREATE_FILE 2>&1
	fi

	if [ `cat ftpps.txt | grep ftpd | grep -v grep | wc -l` -gt 0 ]; then
		if [ -f /etc/default/ftpd ]; then
			if [ `cat /etc/default/ftpd | grep -i '.*umask.*77.*' | grep -v '#'|wc -l` -eq 0 ]; then
				if [ -f /etc/inetd.conf ]; then
					if [ `cat /etc/inetd.conf | grep ftpd | grep -v "#" | grep "\.*77.*" | wc -l` -eq 1 ]; then
						echo "● 4.09 결과 : 양호" >> $CREATE_FILE 2>&1
					else
						echo "● 4.09 결과 : 취약" >> $CREATE_FILE 2>&1
					fi
				else
					echo "● 4.09 결과 : 취약" >> $CREATE_FILE 2>&1
				fi
			else
		        echo "● 4.09 결과 : 양호" >> $CREATE_FILE 2>&1
			fi
		else
			if [ -f /etc/inetd.conf ]; then
				if [ `cat /etc/inetd.conf | grep ftpd | grep -v "#" | grep -v "tftp" | grep "\.*77.*" | wc -l` -eq 1 ]; then
					echo "● 4.09 결과 : 양호" >> $CREATE_FILE 2>&1
				else
					echo "● 4.09 결과 : 취약" >> $CREATE_FILE 2>&1
				fi
			else
				echo "● 4.09 결과 : 취약" >> $CREATE_FILE 2>&1
			fi
		fi
	else
		echo "● 4.09 결과 : 양호" >> $CREATE_FILE 2>&1
	fi
else

	##################
	# Solaris 10 이상
	##################
	if [ `inetadm | grep "online" | egrep 'ftp' | wc -l` -gt 0 ]; then
		echo "☞ inetadm 결과" >> $CREATE_FILE 2>&1
		inetadm | grep "online" | egrep 'ftp' >> $CREATE_FILE 2>&1
		echo " " >> $CREATE_FILE 2>&1
	else
		echo "☞ ftp 서비스 비 실행중입니다. " >> $CREATE_FILE 2>&1
	fi

	if [ `inetadm | grep "online" | egrep 'ftp' | wc -l` -gt 0 ]; then
		if [ -f /etc/ftpd/ftpaccess ]; then
			if [ `inetadm -l svc:/network/ftp:default |grep "exec" |grep "u 077"| grep -v '#'|wc -l` -eq 1 ]; then
				echo "● 4.09 결과 : 양호" >> $CREATE_FILE 2>&1
			else
				echo "● 4.09 결과 : 취약" >> $CREATE_FILE 2>&1
			fi
		else
			echo "● 4.09 결과 : 취약" >> $CREATE_FILE 2>&1
		fi
	else
		echo "● 4.09 결과 : 양호" >> $CREATE_FILE 2>&1
	fi
fi

rm -rf inetd.txt
rm -rf ftpps.txt
echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "4.09 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su4_10() {
echo "4.10 START" >> $CREATE_FILE 2>&1
echo "############################ 4.네트워크 서비스 - 4.10 SMTP(1) - 사용자 정보 제공 방지 ##################################"
echo "############################ 4.네트워크 서비스 - 4.10 SMTP(1) - 사용자 정보 제공 방지 ##################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : SMTP 서비스를 사용하지 않거나 noexpn, novrfy 옵션이 설정되어 있을 경우 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "① Sendmail 프로세스 확인" >> $CREATE_FILE 2>&1
if [ `ps -ef | grep sendmail | grep -v "grep" | wc -l` -eq 0 ]
 then
  echo "Sendmail 서비스가 비실행중입니다." >> $CREATE_FILE 2>&1
 else
  ps -ef | grep sendmail | grep -v "grep" >> $CREATE_FILE 2>&1
fi
echo " " >> $CREATE_FILE 2>&1
ls -al /etc/rc*.d/* | grep -i sendmail | grep "/S" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "② /etc/mail/sendmail.cf 파일의 옵션 확인" >> $CREATE_FILE 2>&1
if [ -f /etc/mail/sendmail.cf ]
  then
    grep -v '^ *#' /etc/mail/sendmail.cf | grep PrivacyOptions >> $CREATE_FILE 2>&1
  else
    echo "/etc/mail/sendmail.cf 파일 없습니다." >> $CREATE_FILE 2>&1
fi



if [ `ps -ef | grep sendmail | grep -v "grep" | wc -l` -eq 0 ]
  then
     echo "● 4.10 결과 : 양호" >> $CREATE_FILE 2>&1
  else
     if [ -f /etc/mail/sendmail.cf ]
      then
      if [ `cat /etc/mail/sendmail.cf | grep -i "O PrivacyOptions" | grep -i "noexpn" | grep -i "novrfy" |grep -v "#" |wc -l ` -eq 1 ]
       then
         echo "● 4.10 결과 : 양호" >> $CREATE_FILE 2>&1
       else
         echo "● 4.10 결과 : 취약" >> $CREATE_FILE 2>&1
      fi
      else
        echo "● 4.10 결과 : 수동" >> $CREATE_FILE 2>&1
     fi
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "4.10 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su4_11() {
echo "4.11 START" >> $CREATE_FILE 2>&1
echo "############################ 4.네트워크 서비스 - 4.11 SMTP(2) _ 일반 사용자의 Sendmail 실행 제한 ##################"
echo "############################ 4.네트워크 서비스 - 4.11 SMTP(2) _ 일반 사용자의 Sendmail 실행 제한 ##################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : SMTP 서비스를 사용하지 않거나 restrictqrun 옵션이 설정되어 있을 경우 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "① Sendmail 프로세스 확인" >> $CREATE_FILE 2>&1
if [ `ps -ef | grep sendmail | grep -v "grep" | wc -l` -eq 0 ]
 then
  echo "Sendmail 서비스가 비실행중입니다." >> $CREATE_FILE 2>&1
 else
  ps -ef | grep sendmail | grep -v "grep" >> $CREATE_FILE 2>&1
fi
echo " " >> $CREATE_FILE 2>&1
ls -al /etc/rc*.d/* | grep -i sendmail | grep "/S" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "② /etc/mail/sendmail.cf 파일의 옵션 확인" >> $CREATE_FILE 2>&1
if [ -f /etc/mail/sendmail.cf ]
  then
    grep -v '^ *#' /etc/mail/sendmail.cf | grep PrivacyOptions >> $CREATE_FILE 2>&1
  else
    echo "/etc/mail/sendmail.cf 파일 없습니다." >> $CREATE_FILE 2>&1
fi


if [ `ps -ef | grep sendmail | grep -v "grep" | wc -l` -eq 0 ]
  then
     echo "● 4.11 결과 : 양호" >> $CREATE_FILE 2>&1
  else
    if [ -f /etc/mail/sendmail.cf ]
     then
     if [ `cat /etc/mail/sendmail.cf | grep -i "O PrivacyOptions" | grep -i "restrictqrun" | grep -v "#" |wc -l ` -eq 1 ]
       then
         echo "● 4.11 결과 : 양호" >> $CREATE_FILE 2>&1
       else
         echo "● 4.11 결과 : 취약" >> $CREATE_FILE 2>&1
     fi
     else
      echo "● 4.11 결과  : 수동" >> $CREATE_FILE 2>&1
    fi
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "4.11 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su4_12() {
echo "4.12 START" >> $CREATE_FILE 2>&1
echo "############################ 4.네트워크 서비스 - 4.12 SMTP(3) _ 릴레이 제한 ##########################"
echo "############################ 4.네트워크 서비스 - 4.12 SMTP(3) _ 릴레이 제한  ##########################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : SMTP 서비스를 사용하지 않거나 릴레이 제한이 설정되어 있을 경우 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "① Sendmail 프로세스 확인" >> $CREATE_FILE 2>&1
if [ `ps -ef | grep sendmail | grep -v "grep" | wc -l` -eq 0 ]
 then
  echo "Sendmail 서비스가 비실행중입니다." >> $CREATE_FILE 2>&1
 else
  ps -ef | grep sendmail | grep -v "grep" >> $CREATE_FILE 2>&1
fi
echo " " >> $CREATE_FILE 2>&1
ls -al /etc/rc*.d/* | grep -i sendmail | grep "/S" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "② /etc/mail/sendmail.cf 파일의 옵션 확인" >> $CREATE_FILE 2>&1
if [ -f /etc/mail/sendmail.cf ]
  then
    cat /etc/mail/sendmail.cf | grep "R$\*" | grep "Relaying denied" >> $CREATE_FILE 2>&1
  else
    echo "/etc/mail/sendmail.cf 파일 없습니다." >> $CREATE_FILE 2>&1
fi



if [ `ps -ef | grep sendmail | grep -v "grep" | wc -l` -eq 0 ]
  then
     echo "● 4.12 결과 : 양호" >> $CREATE_FILE 2>&1
  else
     if [ -f /etc/mail/sendmail.cf ]
      then
        if [ `cat /etc/mail/sendmail.cf | grep -v "^#" | grep "R$\*" | grep -i "Relaying denied" | wc -l ` -gt 0 ]
          then
            echo "● 4.12 결과 : 양호" >> $CREATE_FILE 2>&1
          else
            echo "● 4.12 결과 : 취약" >> $CREATE_FILE 2>&1
        fi
      else
        echo "● 4.12 결과 : 수동" >> $CREATE_FILE 2>&1
     fi
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "4.12 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su4_13() {
echo "4.13 START" >> $CREATE_FILE 2>&1
echo "############################ 4.네트워크 서비스 - 4.13 Telnet _ root 계정 로그인 제한 ##########################"
echo "############################ 4.네트워크 서비스 - 4.13 Telnet _ root 계정 로그인 제한 ##########################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : /etc/default/login 파일에 CONSOLE=/dev/console 라인에 주석(#)이 없으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

if [ $SOL_VERSION = "1" ]
 then

if [ -f /etc/default/login ]
  then
    cat /etc/default/login | grep -i 'console.*' | grep '=' >> $CREATE_FILE 2>&1
  else
    echo "/etc/default/login 파일 없습니다." >> $CREATE_FILE 2>&1
fi


ps -ef | grep inetd  | grep -v grep >> inetd.txt
ps -ef | grep telnetd  | grep -v grep >> telnetps.txt

if [ `cat inetd.txt | grep inetd | grep -v grep | wc -l` -gt 0 ]
 then
 cat /etc/inetd.conf | grep 'telnetd' | grep -v '#' >> telnetps.txt
fi

if [ `cat telnetps.txt | grep telnetd | grep -v grep | wc -l` -gt 0 ]
  then
   if [ -f /etc/default/login ]
    then
     if [ `cat /etc/default/login | grep -i 'console.*=.*/dev/console' | grep -v '#' | wc -l ` -eq 1 ]
      then
       echo "● 4.13 결과 : 양호" >> $CREATE_FILE 2>&1
      else
       echo "● 4.13 결과 : 취약" >> $CREATE_FILE 2>&1
     fi
    else
     echo "● 4.13 결과 : 취약" >> $CREATE_FILE 2>&1
   fi
  else
   echo "☞ Telnet 서비스 비 실행중입니다." >> $CREATE_FILE 2>&1
   echo "● 4.13 결과 : 양호" >> $CREATE_FILE 2>&1
fi
else

if [ -f /etc/default/login ]
  then
    cat /etc/default/login | grep -i 'console.*' | grep '=' >> $CREATE_FILE 2>&1
  else
    echo "/etc/default/login 파일 없습니다." >> $CREATE_FILE 2>&1
fi

if [ `inetadm | grep "online" | egrep 'telnet' | wc -l` -gt 0 ]
then
   if [ -f /etc/default/login ]
    then
     if [ `cat /etc/default/login | grep -i 'console.*=.*/dev/console' | grep -v '#' | wc -l ` -eq 1 ]
      then
       echo "● 4.13 결과 : 양호" >> $CREATE_FILE 2>&1
      else
       echo "● 4.13 결과 : 취약" >> $CREATE_FILE 2>&1
     fi
    else
     echo "● 4.13 결과 : 취약" >> $CREATE_FILE 2>&1
   fi
  else
   echo "☞ Telnet 서비스 비 실행중입니다." >> $CREATE_FILE 2>&1
   echo "● 4.13 결과 : 양호" >> $CREATE_FILE 2>&1
fi
fi

rm -rf telnetps.txt
rm -rf inetd.txt
echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "4.13  END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}


su4_14() {
echo "4.14 START" >> $CREATE_FILE 2>&1
echo "############################ 4.네트워크 서비스 - 4.14 SNMP _ Community String 설정 #################################"
echo "############################ 4.네트워크 서비스 - 4.14 SNMP _ Community String 설정 #################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : SNMP 서비스를 사용하지 않거나 Community String이 public, private 이 아닐 경우 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "① SNMP 서비스 여부 " >> $CREATE_FILE 2>&1
if [ `ps -ef | grep snmp | grep -v "dmi" | grep -v "grep" | wc -l` -eq 0 ]
  then
    echo "SNMP가 비실행중입니다. "  >> $CREATE_FILE 2>&1
  else
    ps -ef | grep snmp | grep -v "dmi" | grep -v "grep" >> $CREATE_FILE 2>&1
fi
echo " " >> $CREATE_FILE 2>&1
ls -al /etc/rc*.d/* | grep -i snmp | grep "/S" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "② /etc/snmp/conf/snmpd.conf 파일 " >> $CREATE_FILE 2>&1
if [ -f /etc/snmp/conf/snmpd.conf ]
        then
           grep -v '^ *#' /etc/snmp/conf/snmpd.conf | egrep -i "public|private" | egrep -v "group|trap" >> $CREATE_FILE 2>&1
        else
          echo " /etc/snmp/conf/snmpd.conf 파일이 존재하지 않습니다. " >> $CREATE_FILE 2>&1
fi


if [ `ps -ef | grep snmp | grep -v "dmi" | grep -v "grep" | wc -l` -eq 0 ]
  then
     echo "● 4.14 결과 : 양호" >> $CREATE_FILE 2>&1
  else
  if [ -f /etc/snmp/conf/snmpd.conf ]
    then
     if [ `cat /etc/snmp/conf/snmpd.conf | egrep -i "public|private" | grep -v "#" | egrep -v "group|trap" | wc -l ` -eq 0 ]
       then
         echo "● 4.14 결과 : 양호" >> $CREATE_FILE 2>&1
       else
         echo "● 4.14 결과 : 취약" >> $CREATE_FILE 2>&1
     fi
   else
     echo "● 4.14 결과 : 수동" >> $CREATE_FILE 2>&1
fi
fi
echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "4.14 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su4_15() {
echo "4.15 START" >> $CREATE_FILE 2>&1
echo "############################ 4.네트워크 서비스 - 4.15 DNS _ Zone Transfer 설정 ###########################"
echo "############################ 4.네트워크 서비스 - 4.15 DNS _ Zone Transfer 설정 ###########################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : DNS 서비스를 사용하지 않거나 Zone Transfer 가 제한되어 있을 경우 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "① DNS 프로세스 확인 " >> $CREATE_FILE 2>&1
if [ `ps -ef | grep named | grep -v "grep" | wc -l` -eq 0 ]
  then
    echo "DNS가 비실행중입니다." >> $CREATE_FILE 2>&1
  else
    ps -ef | grep named | grep -v "grep" >> $CREATE_FILE 2>&1
fi
echo " " >> $CREATE_FILE 2>&1
ls -al /etc/rc*.d/* | grep -i named | grep "/S" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "☞/etc/rc2.d/S72inetsvc 파일내용" >> $CREATE_FILE 2>&1
cat /etc/rc2.d/S72inetsvc | grep -i named >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "② /etc/named.conf 파일의 allow-transfer 확인" >> $CREATE_FILE 2>&1
   if [ -f /etc/named.conf ]
     then
      cat /etc/named.conf | grep 'allow-transfer' >> $CREATE_FILE 2>&1
     else
      echo "/etc/named.conf 파일 없습니다." >> $CREATE_FILE 2>&1
   fi

echo " " >> $CREATE_FILE 2>&1

echo "③ /etc/named.boot 파일의 xfrnets 확인" >> $CREATE_FILE 2>&1
   if [ -f /etc/named.boot ]
     then
       cat /etc/named.boot | grep "\xfrnets" >> $CREATE_FILE 2>&1
     else
       echo "/etc/named.boot 파일 없습니다." >> $CREATE_FILE 2>&1
   fi



if [ `ps -ef | grep named | grep -v "grep" | wc -l` -eq 0 ]
  then
     echo "● 4.15 결과 : 양호" >> $CREATE_FILE 2>&1
  else
     if [ -f /etc/named.conf ]
       then
         if [ `cat /etc/named.conf | grep "\allow-transfer.*[0-256].[0-256].[0-256].[0-256].*" | grep -v "#" | wc -l` -eq 0 ]
            then
               echo "● 4.15 결과 : 취약" >> $CREATE_FILE 2>&1
            else
               echo "● 4.15 결과 : 양호" >> $CREATE_FILE 2>&1
          fi
        else
          if [ -f /etc/named.boot ]
           then
             if [ `cat /etc/named.boot | grep "\xfrnets.*[0-256].[0-256].[0-256].[0-256].*" | grep -v "#" | wc -l` -eq 0 ]
            then
               echo "● 4.15 결과 : 취약" >> $CREATE_FILE 2>&1
            else
               echo "● 4.15 결과 : 양호" >> $CREATE_FILE 2>&1
            fi
           else
              echo "● 4.15 결과 : 수동" >> $CREATE_FILE 2>&1
          fi

     fi
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "4.15 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}


su4_16() {
echo "4.16 START" >> $CREATE_FILE 2>&1
echo "############################ 4.네트워크 서비스 - 4.16 xhost+ 설정 #####################################"
echo "############################ 4.네트워크 서비스 - 4.16 xhost+ 설정 #####################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : 자동 실행화일 파일에 “xhost +” 설정이 존재하지 않을 경우 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
HOMEDIRS=`cat /etc/passwd | awk -F":" 'length($6) > 0 {print $6}' | sort -u | grep -v "#" | grep -v "/tmp" | grep -v "uucppublic" | uniq`
FILES="/.profile /.cshrc /.kshrc /.login /.bash_profile /.bashrc /.bash_login /.xinitrc /.xsession"

for file in $FILES
  do
    if [ -f $file ]
      then
        echo " cat $file " >> $CREATE_FILE 2>&1
        echo " ------------" >> $CREATE_FILE 2>&1
        grep -v '^ *#' $file | grep "xhost +" >> $CREATE_FILE 2>&1
      else
        echo $file " 파일 없습니다." >> $CREATE_FILE 2>&1
    fi
done

for dir in $HOMEDIRS
do
  for file in $FILES
  do
    if [ -f $dir$file ]
      then
        echo " cat $dir$file " >> $CREATE_FILE 2>&1
        echo "----------------" >> $CREATE_FILE 2>&1
        grep -v '^ *#' $dir$file | grep "xhost +" >> $CREATE_FILE 2>&1
      else
       echo $dir$file " 파일 없습니다." >> $CREATE_FILE 2>&1
    fi
  done
done



echo " " > xhost.txt
HOMEDIRS=`cat /etc/passwd | awk -F":" 'length($6) > 0 {print $6}' | sort -u | grep -v "#" | grep -v "/tmp" | grep -v "uucppublic" | uniq`
FILES="/.profile /.cshrc /.kshrc /.login /.bash_profile /.bashrc /.bash_login /.xinitrc /.xsession"

for file in $FILES
  do
    if [ -f $file ]
      then
        if [ `cat $file | grep "xhost.*+" | grep -v "#" | wc -l` -eq 0 ]
          then
             echo "● 4.16 결과 : 양호" >> xhost.txt
          else
             echo "● 4.16 결과 : 취약" >> xhost.txt
        fi
      else
       echo "  " >> xhost.txt
      echo "● 4.16 결과 : 양호" >> xhost.txt
    fi
done

for dir in $HOMEDIRS
do
  for file in $FILES
  do
    if [ -f $dir$file ]
      then
        if [ `cat $dir$file | grep "xhost.*+" | grep -v "#" | wc -l` -eq 0 ]
          then
             echo "● 4.16 결과 : 양호" >> xhost.txt
          else
             echo "● 4.16 결과 : 취약" >> xhost.txt
        fi
      else
       echo "● 4.16 결과 : 양호" >> xhost.txt
    fi
  done
done

if [ `cat xhost.txt | grep "취약" | wc -l` -eq 0 ]
 then
  echo "● 4.16 결과 : 양호" >> $CREATE_FILE 2>&1
 else
  echo "● 4.16 결과 : 취약" >> $CREATE_FILE 2>&1
fi

rm -rf xhost.txt
unset HOMEDIRS
unset FILES

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "4.16 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su4_17(){
echo "4.17 START" >> $CREATE_FILE 2>&1
echo "############################ 4.네트워크 서비스 - 4.17 불필요한 서비스 #################################"
echo "############################ 4.네트워크 서비스 - 4.17 불필요한 서비스 #################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : 불필요한 서비스가 사용되고 있지 않으면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

if [ $SOL_VERSION = "1" ]
 then
   SERVICE_INETD="echo|discard|daytime|chargen|time|tftp|finger|sftp|uucp-path|nntp|ntp|netbios_ns|netbios_dgm|netbios_ssn|bftp|ldap|printer|talk|ntalk|uucp|pcserver|ldaps|ingreslock|www-ldap-gw|nfsd|dtspcd"
     if [ `cat /etc/inetd.conf | grep -v '^ *#' | egrep $SERVICE_INETD | wc -l ` -gt 0 ]
        then
         cat /etc/inetd.conf | grep -v '^#' | egrep $SERVICE_INETD >> $CREATE_FILE 2>&1
        else
         echo "불필요한 서비스가 존재하지않습니다" >> $CREATE_FILE 2>&1
     fi


     if [ -f /etc/inetd.conf ]
        then
          if [ `cat /etc/inetd.conf | grep -v '^ *#' | egrep $SERVICE_INETD | wc -l ` -eq 0 ]
             then
               echo "● 4.17 결과 : 양호" >> $CREATE_FILE 2>&1
             else
              echo "● 4.17 결과 : 취약" >> $CREATE_FILE 2>&1
          fi
       else
         echo "● 4.17 결과 : 양호" >> $CREATE_FILE 2>&1
    fi
else
    if [ `inetadm | egrep 'echo|discard|daytime|chargen|time|tftp|finger|sftp|uucp-path|nntp|ntp|netbios_ns|netbios_dgm|netbios_ssn|bftp|ldap|printer|talk|ntalk|uucp|pcserver|ldaps|ingreslock|www-ldap-gw|nfsd|dtspcd' | grep "online" | wc -l` -eq 0 ]
       then
          echo "불필요한 서비스가 사용되고 있지 않습니다." >> $CREATE_FILE 2>&1
       else
           inetadm | egrep 'echo|discard|daytime|chargen|time|tftp|finger|sftp|uucp-path|nntp|ntp|netbios_ns|netbios_dgm|netbios_ssn|bftp|ldap|printer|talk|ntalk|uucp|pcserver|ldaps|ingreslock|www-ldap-gw|nfsd|dtspcd' | grep "online" >> $CREATE_FILE 2>&1
    fi
    echo " " >> $CREATE_FILE 2>&1
    if [ `inetadm | egrep 'echo|discard|daytime|chargen|time|tftp|finger|sftp|uucp-path|nntp|ntp|netbios_ns|netbios_dgm|netbios_ssn|bftp|ldap|printer|talk|ntalk|uucp|pcserver|ldaps|ingreslock|www-ldap-gw|nfsd|dtspcd' | grep "online" | wc -l` -eq 0 ]
       then
          echo "● 4.17 결과 : 양호" >> $CREATE_FILE 2>&1
       else
          echo "● 4.17 결과 : 취약" >> $CREATE_FILE 2>&1
    fi
fi
unset SERVICE_INETD
echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "4.17 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su5_01() {
echo "5.01 START" >> $CREATE_FILE 2>&1
echo "############################ 5.감사 및 로그관리 - 5.1 su 로그 설정 #############################################"
echo "############################ 5.감사 및 로그관리 - 5.1 su 로그 설정 #############################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 :/etc/default/su 파일에 SULOG=/var/adm/sulog 설정이 되어 있거나 /etc/syslog.conf 파일에 auth.notice 또는 auth.info를 파일로 남기면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
if [ -f /etc/default/su ]
  then
    echo "☞etc/default/su 파일 점검" >> $CREATE_FILE 2>&1
    cat /etc/default/su | grep -i "SULOG" >> $CREATE_FILE 2>&1
  else
    echo "/etc/default/su 파일없습니다." >> $CREATE_FILE 2>&1
fi
echo " " >> $CREATE_FILE 2>&1
if [ -f /etc/syslog.conf ]
     then
      echo "☞/etc/syslog.conf  파일 점검" >> $CREATE_FILE 2>&1
      cat /etc/syslog.conf | egrep 'auth.notice|auth.info'  >> $CREATE_FILE 2>&1
     else
       echo "/etc/syslog.conf  파일 없습니다." >> $CREATE_FILE 2>&1
fi


if [ -f /etc/default/su ]
 then
    if [ `cat /etc/default/su | grep -i "SULOG" | grep -v '#' | egrep 'var|log' | wc -l` -gt 0 ]
     then
       echo "● 5.01 결과 : 양호" >> $CREATE_FILE 2>&1
     else
      if [ -f /etc/syslog.conf ]
       then
        if [ `cat /etc/syslog.conf | grep -i "auth.notice|auth.info" | egrep 'var|log' | grep -v '#' | wc -l` -eq 0 ]
         then
          echo "● 5.01 결과 : 취약" >> $CREATE_FILE 2>&1
         else
          echo "● 5.01 결과 : 양호" >> $CREATE_FILE 2>&1
        fi
       else
         echo "● 5.01 결과 : 취약" >> $CREATE_FILE 2>&1
      fi
    fi
  else
    echo "● 5.01 결과 : 취약" >> $CREATE_FILE 2>&1
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "5.01 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su5_02() {
echo "5.02 START" >> $CREATE_FILE 2>&1
echo "############################ 5.감사 및 로그관리 - 5.2 Inetd Services 로그설정(Solaris Only) #################################"
echo "############################ 5.감사 및 로그관리 - 5.2 Inetd Services 로그설정(Solaris Only) #################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 :Inetd Services 로그 설정이 되어 있으면 양호(9버전은 /etc/init.d/inetsvc에서 /usr/sbin/inetd -s -t &, 10버전은 inetadm에서 tcp_trace=TRUE)" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

if [ $SOL_VERSION = "1" ]
 then
	if [ `cat /etc/init.d/inetsvc |grep "inetd" | grep "\-t" |wc -l` -eq 0 ]
		then
			cat /etc/init.d/inetsvc |grep "inetd" >> $CREATE_FILE 2>&1
			echo "● 5.02 결과 : 취약" >> $CREATE_FILE 2>&1
		else
			cat /etc/init.d/inetsvc |grep "inetd" >> $CREATE_FILE 2>&1
			echo "● 5.02 결과 : 양호" >> $CREATE_FILE 2>&1	
	fi
 else
	if [ `inetadm -p |grep "tcp_trace=TRUE" | wc -l` -eq 0 ]
		then 
			inetadm -p |grep "tcp_trace=" >> $CREATE_FILE 2>&1
			echo "● 5.02 결과 : 취약" >> $CREATE_FILE 2>&1
		else
			inetadm -p |grep "tcp_trace=" >> $CREATE_FILE 2>&1
			echo "● 5.02 결과 : 양호" >> $CREATE_FILE 2>&1	
	fi
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "5.02 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su5_03() {
echo "5.03 START" >> $CREATE_FILE 2>&1
echo "############################ 5.감사 및 로그관리 - 5.3 syslog 설정 ##############################################"
echo "############################ 5.감사 및 로그관리 - 5.3 syslog 설정 ##############################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : syslog 에 중요 로그 정보에 대한 설정이 되어 있을 경우 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "☞ syslog 프로세스" >> $CREATE_FILE 2>&1
ps -ef | grep 'syslog' | grep -v 'grep' >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "☞ 시스템 로깅 설정" >> $CREATE_FILE 2>&1
if [ -f /etc/syslog.conf ] 
 then
  cat /etc/syslog.conf | grep -v "#" >> $CREATE_FILE 2>&1
 else
  echo "/etc/syslog.conf 파일 없습니다." >> $CREATE_FILE 2>&1
fi

echo " " > syslog.txt

if [ `cat /etc/syslog.conf | egrep "info|alert|notice|debug" | egrep "var|log" | wc -l` -gt 0 ]
     then
       echo "● 5.03 결과 : 양호" >> syslog.txt
     else
       echo "● 5.03 결과 : 취약" >> syslog.txt
fi

if [ `cat /etc/syslog.conf | egrep "alert|err|crit" | egrep "console|sysmsg" | wc -l` -gt 0 ]
     then
       echo "● 5.03 결과 : 양호" >> syslog.txt
     else
       echo "● 5.03 결과 : 취약" >> syslog.txt
fi

if [ `cat /etc/syslog.conf | grep "emerg" | grep "\*" | wc -l` -gt 0 ]
     then
       echo "● 5.03 결과 : 양호" >> syslog.txt
     else
       echo "● 5.03 결과 : 취약" >> syslog.txt
fi


if [ `cat syslog.txt | grep "취약" | wc -l` -eq 0 ]
 then
  echo "● 5.03 결과 : 양호" >> $CREATE_FILE 2>&1
 else
  echo "● 5.03 결과 : 취약" >> $CREATE_FILE 2>&1
fi

rm -rf syslog.txt

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "5.03 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su6_01() {
echo "6.01 START" >> $CREATE_FILE 2>&1
echo "############################ 6.패치관리- 6.1 Sendmail 패치 ###############################"
echo "############################ 6.패치관리- 6.1 Sendmail 패치 ###############################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : sendmail 버전이 8.13.8 이상이면 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "① Sendmail 프로세스 확인" >> $CREATE_FILE 2>&1
if [ `ps -ef | grep sendmail | grep -v "grep" | wc -l` -eq 0 ]
 then
  echo "Sendmail 서비스가 비실행중입니다." >> $CREATE_FILE 2>&1
 else
  ps -ef | grep sendmail | grep -v "grep" >> $CREATE_FILE 2>&1
fi
echo " " >> $CREATE_FILE 2>&1
ls -al /etc/rc*.d/* | grep -i sendmail | grep "/S" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "② sendmail 버전확인" >> $CREATE_FILE 2>&1
if [ -f /etc/mail/sendmail.cf ]
   then
     grep -v '^ *#' /etc/mail/sendmail.cf | grep DZ >> $CREATE_FILE 2>&1
   else
     echo "/etc/mail/sendmail.cf 파일 없습니다." >> $CREATE_FILE 2>&1
fi

if [ `ps -ef | grep sendmail | grep -v "grep" | wc -l` -eq 0 ]
  then
     echo "● 6.01 결과 : 양호" >> $CREATE_FILE 2>&1
  else
    if [ -f /etc/mail/sendmail.cf ]
     then
     if [ `grep -v '^ *#' /etc/mail/sendmail.cf | egrep "DZ8.13.8|8.14.0|8.14.1" | wc -l ` -eq 1 ]
       then
         echo "● 6.01 결과 : 양호" >> $CREATE_FILE 2>&1
       else
         echo "● 6.01 결과 : 취약" >> $CREATE_FILE 2>&1
     fi
     else
      echo "● 6.01 결과 : 수동" >> $CREATE_FILE 2>&1
     fi
fi

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "6.01 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su6_02() {
echo "6.02 START" >> $CREATE_FILE 2>&1
echo "############################ 6.패치관리- 6.2 DNS 패치 ###############################"
echo "############################ 6.패치관리- 6.2 DNS 패치 ###############################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준 : DNS 서비스를 사용하지 않거나, 양호한 버전을 사용하고 있을 경우에 양호(8.4.6, 8.4.7, 9.2.8-P1, 9.3.4-P1, 9.4.1-P1, 9.5.0a6)" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

vul_flag=0

DNSPR=`ps -ef | grep named | grep -v "grep" | awk 'BEGIN{ OFS="\n"} {i=1; while(i<=NF) {print $i; i++}}'| grep "/" | uniq`
DNSPR=`echo $DNSPR | awk '{print $1}'`
if [ `ps -ef | grep named | grep -v grep | wc -l` -gt 0 ]; then
	if [ -f $DNSPR ]; then
		echo "BIND 버전 확인" >> $CREATE_FILE 2>&1
		echo "--------------" >> $CREATE_FILE 2>&1
		$DNSPR -v | grep BIND >> $CREATE_FILE 2>&1
	else
		echo "$DNSPR 파일 없습니다." >> $CREATE_FILE 2>&1
	fi

	echo "☞ dig 명령을 사용한 Cache Poisoning 취약점 확인" >> $CREATE_FILE 2>&1
	dig @localhost +short porttest.dns-oarc.net TXT >> dig_cache.txt 2>&1
	if [ `cat dig_cache.txt |grep -i "seconds from" |grep -i "ports with" |wc -l` -ge 1 ]; then
		vul_flag=1
	fi
	echo " " >> $CREATE_FILE 2>&1

	echo "☞ nslookup 명령을 사용한 Cache Poisoning 취약점 확인" >> $CREATE_FILE 2>&1
	
	nslookup -type=txt -timeout=30 porttest.dns-oarc.net localhost >> nslookup_cache.txt 2>&1
	if [ `cat nslookup_cache.txt |grep -i "y.x.w.v.u.t.s.r.q.p.o.n.m.l.k.j.i.h.g.f.e.d.c.b.a.pt.dns-oarc.net" |wc -l` -ge 1 ]; then
		vul_flag=1
	fi


else
	echo "DNS가 비실행중입니다 " >> $CREATE_FILE 2>&1
fi

echo " " >> $CREATE_FILE 2>&1

if [ `ps -ef | grep named | grep -v "grep" | wc -l` -eq 0 ]; then
	echo "● 6.02 결과 : 양호" >> $CREATE_FILE 2>&1
else
	if [ $vul_flag -eq 1 ]; then
		echo "● 6.02 결과 : 취약" >> $CREATE_FILE 2>&1
	else
		if [ -f $DNSPR ]; then
			if [ `$DNSPR -v | grep BIND | egrep '8.4.6 | 8.4.7 | 9.2.8-P1 | 9.3.4-P1 | 9.4.1-P1 | 9.5.0a6' | wc -l` -gt 0 ]; then
				echo "● 6.02 결과 : 양호" >> $CREATE_FILE 2>&1
			else
				echo "● 6.02 결과 : 취약" >> $CREATE_FILE 2>&1
			fi
		else
			echo "● 6.02 결과 : 수동" >> $CREATE_FILE 2>&1
		fi
	fi
fi
rm -rf dig_cache.txt
rm -rf nslookup_cache.txt

unset DNSPR

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "6.02 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

su6_03() {
echo "6.03 START" >> $CREATE_FILE 2>&1
echo "############################ 6.패치관리- 6.3 시스템 패치 #################################################"
echo "############################ 6.패치관리- 6.3 시스템 패치 #################################################" >> $CREATE_FILE 2>&1
echo "--------------------------------------------------------------------------------------------------------" >> $CREATE_FILE 2>&1
echo "■ 기준: 패치 적용 정책을 수립하여 주기적으로 패치를 관리하고 있을 경우에 양호" >> $CREATE_FILE 2>&1
echo "■ 현황" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
showrev -p >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "● 6.03 결과 : 수동" >> $CREATE_FILE 2>&1

echo "########################################################################################################" >> $CREATE_FILE 2>&1
echo "========================================================================================================" >> $CREATE_FILE 2>&1
echo "6.03 END" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
}

# 아래의 점검항목 중에서 진단하지 않을 항목에 대해서는 주석처리("#")를 수행하시면 됩니다.
# SU1. 계정 관리
su1_01
su1_02
su1_03
su1_04
su1_05
su1_06
su1_07
su1_08

# SU2. 접근통제
su2_01
su2_02
su2_03
su2_04
su2_05
su2_06
su2_07
su2_08
su2_09
su2_10
su2_11
su2_12
su2_13
su2_14


# SU3.  시스템 환경설정
su3_01
su3_02
su3_03
su3_04
su3_05
su3_06

# SU4. 네트워크 서비스
su4_01
su4_02
su4_03
su4_04
su4_05
su4_06
su4_07
su4_08
su4_09
su4_10
su4_11
su4_12
su4_13
su4_14
su4_15
su4_16
su4_17

# SU5. 감사 및 로그관리
su5_01
su5_02
su5_03

# SU6. 패치관리
su6_01
su6_02
su6_03

echo "************************************************** END *************************************************" 
date 
echo "************************************************** END *************************************************"

echo "☞ 진단작업이 완료되었습니다. 수고하셨습니다!"