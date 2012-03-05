curl -k -A Test \
        --header "Content-Type: multipart/mixed" \
        --header "MIME-version: 1.0" \
        --form "fileupload=@sample.xml;type=text/xml" \
        --form "fileupload2=@sample.wav;type=audio/wav" \
        http://localhost:8080/multipart

#        --trace h.txt \
