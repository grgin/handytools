#!/bin/bash

# get image names, dimensions, and preview of all the images in the subfolders as an html file


cat << EOF > image_data.html
<table style="background: beige;">
<thead>
<tr><th>Filename</th><th>Dimensions</th><th>Image</th></tr>
</thead>
<tbody>
EOF

find . -type f -name "*.png" | while read -r png_file; do
  filename=$(basename "$png_file")
  dimensions=$(sips -g pixelWidth -g pixelHeight "$png_file" | awk '/pixelWidth/{width=$2} /pixelHeight/{print width "x" $2}')
  cat << EOF >> image_data.html
<tr>
<td>$filename</td>
<td>$dimensions</td>
<td><image src="$png_file" style="height: 100px;"></image></td>
</tr>
EOF
done

cat << EOF >> image_data.html
</tbody>
</table>
EOF
