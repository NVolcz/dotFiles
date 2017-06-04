#!/usr/bin/env python
import argparse,sys,os,smtplib
sender = "random@example.com"
recv = "random@example.com"
sub = "Test"
server = "localhost" 

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
def send_Mail(sender, recv, subject, server):
    me = send
    you = recv
    sub = subject
    smtp_server = server

    # Create message container - the correct MIME type is multipart/alternative.
    msg = MIMEMultipart('alternative')
    msg['Subject'] = sub
    msg['From'] = me
    msg['To'] = you

    msg.add_header('Content-Type','text/html')
    msg.set_payload(message)
    print('######## Preview of Your Message: ########')
    print(msg.as_string())
    print('######## ------- End Message ----- ########')
    #s.starttls()
    #s.login(email_login, email_passwd)
    s = smtplib.SMTP(smtp_server)
    s.sendmail(msg['From'], [msg['To']], msg.as_string())
    s.quit()


parser = argparse.ArgumentParser()
parser.add_argument('-f','--send',default='change@me.com', help='Sender of this message.')
parser.add_argument('-r','--recv',default='billgates@microsoft.com', help='Recipitent of this message.')
parser.add_argument('-m','--message',default='message.txt', help='File containing message content to send.')
parser.add_argument('-S','--subject',default='You Suck', help='Subject of email to send.')
parser.add_argument('-s','--server',default='localhost', help='Hostname or ip of the smtp server to use.')

ns = parser.parse_args()

send = ns.send if ns.send is not None else "default_sender"
recv = ns.recv if ns.recv is not None else "default_recv"
message = ns.message if ns.message is not None else "default_message"
subject = ns.subject if ns.subject is not None else "defaut_subject"
server = ns.server if ns.server is not None else "default_server"

try:
    print("Sender: %s" % send)
    print("Recipitent: %s" % recv)
    print("Subject: %s" % subject)
    print("Server: %s" % server)
except Exception as e:
    print(e)

try:
    f = open(message, 'r')
except IOError:
    print ("[!] Cannot open %s, does it exist?" % message)
    sys.exit(1)
else:
    message=[]
    message=f.read()
    #print("Message:\n-----------------\n%s\n---------------" % message)
    try:
        send_Mail(sender, recv, subject, server)
    except Exception as x:
        print(x)
    f.close()

