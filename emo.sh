#!/bin/bash


DOSYAOLUSTUR()
{
        fileName=$(whiptail --inputbox "Yeni dosya olustur" 15 80  --title "Dosya olusturma" --fb --nocancel 3>&1 1>&2 2>&3)
        result=$?
        if [ $result -eq 0 ]
        then touch $fileName
        else
            echo "Kullanıcı tarafindan iptal edildi."
        fi
}


SAYISALIZNIDEGISTIR()
{
        secilenDosya=`zenity --file-selection --text="Dosya seciniz!!!"`
        if [ $? -eq 0 ]
        then
                expre=$(whiptail --inputbox " (000-777) Arasi ifade giriniz!!!" 15 80  --title "Aciklama" --fb --nocancel 3>&1 1>&2 2>&3)
                result=$?
                if [ $result -eq 0 ]
                then chmod $expre $secilenDosya
                else
                    echo "Kullanici tarafindan iptal edildi."
                fi

        else whiptail --msgbox "Dosya seçilmedi !!" 10 100
        fi
}
ICERIK()
{
        secilenDosya=`zenity --width=700 --height=500 --list --column="Goruntulemek istediginiz dosyayi seciniz!!!" $(ls)`
        if [ -n "$secilenDosya" ]
        then
                first=$(whiptail --inputbox "Hangi satirdan baslanacagini yaziniz..." --fb  --nocancel 10 100 3>&1 1>&2 2>&3)
                if [ -n $first ]
                then

                        second=$(whiptail --inputbox "Hangi satıra kadar olacagini yaziniz... " --fb --nocancel  10 100 3>&1 1>&2 2>&3)
                        echo "first:" $first
                        if [ -n $second ]
                        then    echo "second" $second;
                                ifade=`cat $secilenDosya | head -$second`
                                printf "$ifade" > deneme.txt
                                sayi=`expr $second - $first + 1`
                                ifade2=`cat deneme.txt | tail -$sayi`
                                printf "$ifade2" > deneme.txt
                                echo $ifade2
                                #printf "$ifade" > deneme.txt
                                        {
                                         for i in {0..100..10}
                                         do
                                         sleep .1
                                         echo $i
                                         done
                                        } | whiptail --gauge "Yukleniyor Lutfen Bekleyiniz!!!" 6 60 0


                                whiptail --textbox deneme.txt 40 100 --scrolltext --fb --nocancel
                        else echo "iptal edildi"
                        fi
                else echo "iptal"
                fi

        else zenity --warning --text="Dosya seçilmedi !!" --width=300
        fi
}


while true
do
        CHOICE=$(whiptail --menu "MENU SECIMI" 18 100 10  --fb --nocancel \
         "1" "DOSYA OLUSTUR" \
         "2" "SAYISAL IZNI DEGISTIR" \
         "3" "BELLI SATIRLAR ARASI ICERIGINI GORUNTULUME" \
         "4" "CIKIS YAP"  3>&1 1>&2 2>&3)
        if [ -z "$CHOICE" ]
        then
         echo "HICBIR SECENEK SECILMEDI"
        else
         case $CHOICE in
           "1") DOSYAOLUSTUR;;
           "2") SAYISALIZNIDEGISTIR ;;
           "3") ICERIK;;
           "4") exit 1;;
           *) echo "Default";;
         esac
        fi
done
