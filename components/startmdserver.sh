
if [ -e ~/.mdserver ]; then
    rm -r ~/.mdserver;
fi;

mkdir ~/.mdserver

echo "
<html>
<head>
<title>
Markdown Server
</title>
</head>
<body>
" > ~/.mdserver/index.html


for f in $(ls | egrep '\.(mdown|markdown|md)$'); do
    
    name=$(echo $f | cat | sed 's/\(.*\)\..*$/\1/');
    
    echo "<html><head><title>$name</title></head><body><a href='/'>Back</a>" > ~/.mdserver/$name.html;
    
    $md $f >> ~/.mdserver/$name.html;

    echo "</body></html>" >>  ~/.mdserver/$name.html;

    echo "<a href='$name'>$name</a><br />" >> ~/.mdserver/index.html;

done

echo "</body></html>" >> ~/.mdserver/index.html;


simpleserver $HOME
