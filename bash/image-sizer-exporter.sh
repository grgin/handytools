#!/bin/bash

# get image names, dimensions, and preview of all the images in the subfolders as an custom html file


cat << EOF > image_data.html
<body style="background: lightgrey;">
<table style="width: 80vw; text-align: center; margin: auto;">
<thead>
<tr><th></th><th>Filename</th><th>Dimensions</th><th>Image</th></tr>
</thead>
<tbody>
EOF

find . -type f -name "*.png" | while read -r png_file; do
  filename=$(basename "$png_file")
  dimensions=$(sips -g pixelWidth -g pixelHeight "$png_file" | awk '/pixelWidth/{width=$2} /pixelHeight/{print width "x" $2}')
  cat << EOF >> image_data.html
<tr>
<td><button type="button" class="minus">-</button>
<td class="content">$filename</td>
<td class="content">$dimensions</td>
<td class="content"><image src="$png_file" style="height: 100px;"></image></td>
</tr>
EOF
done

cat << EOF >> image_data.html
</tbody>
</table>
<script>
    document.addEventListener('click', function(event){
        const clickedElement = event.target;
        if(clickedElement.tagName === "BUTTON")
        { 
            const parentElement = clickedElement.parentElement.parentElement; 
            if(clickedElement.className === "minus")
            {
                clickedElement.className = '';
                clickedElement.innerHTML = "+"
                Array.from(parentElement.children).filter(child => child !== clickedElement.parentElement).forEach(element => {
                    element.hidden = true;
                });
            }
            else{
                clickedElement.className = 'minus';
                clickedElement.innerHTML = "-"
                Array.from(parentElement.children).filter(child => child !== clickedElement.parentElement).forEach(element => {
                    element.hidden = false;
                });
            }
        }
    });
</script>
</body>
EOF
