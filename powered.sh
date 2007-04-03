#!/bin/bash

{
echo "<html><head><title>Jetty Powered</title><link rel=stylesheet type=text/css href=powered.css></head>"
echo "<body>"

echo "<TABLE cellspacing=\"10\" cellpadding=\"5\" width=\"100%\">"

echo "<p class=\"hdr\">&nbsp;Jetty Powered</p>"
echo "<p>As a small, fast, embeddable web server and servlet container Jetty is used by a multitude of both commercial and open source products."
echo "These Jetty Powered products illustrate Jetty's versatility and the diversity of it's community. </p><p>Send your submission with a product logo (if you have one) and brief text describing your product to <code>powered AT mortbay.com</code> if you would like your product or project listed here.</p>"


C=0

cat powered.txt | while read LINE
do
  TAG=$(expr "$LINE" : '\([A-Z]*\):')
  ARG=$(expr "$LINE" : "$TAG:\(.*\)")

  case "$TAG" in
    HREF* )   
     HREF=$ARG
     if [ $(expr $C % 2 ) == 0 ]
     then 
         [ $C -gt 0 ] && echo "</P></TD></TR>"
         echo "<TR><TD  colspan=2>&nbsp;</TD></TR><TR>"
     else
         echo "</P></TD>"
     fi
     echo "<TD class=\"power\" align=center width=\"50%\" valign=bottom>"

     C=$(expr "$C" + 1)
     ;;

    IMAGE* )  
     IMAGE=$ARG
     echo "<A href=\"$HREF\"><IMG border=0  src=\"images/$IMAGE\"></A><BR>"
     ;;

    NAME* )  
     NAME=$ARG
     echo "<A href=\"$HREF\"><H3>$NAME</H3></A><P class=\"blurb\">"
     ;;

    *) echo $LINE
     ;;
  esac

done

echo "</TD></TR></TABLE>"
echo "</body>"

} > index.html

{

cat powered.txt | while read LINE
do
  TAG=$(expr "$LINE" : '\([A-Z]*\):')
  ARG=$(expr "$LINE" : "$TAG: *\(.*\) *")

  case "$TAG" in
    HREF* )   
     HREF=$ARG
     IMAGE=
     ;;

    IMAGE* )  
     IMAGE=$ARG
     ;;

    NAME* )  
     NAME=$ARG
     echo "h1. [$NAME|$HREF]"
     [ x$IMAGE != x ] && echo "!http://svn.codehaus.org/jetty/powered/images/$IMAGE!"
     echo
     ;;

    *) echo $LINE
     ;;
  esac

done

} > index.wiki


