
user=$1
login=$( curl -L -c cookies.txt -d "txt_username=$1&txt_password=$1&btn_login=Login" http://akademik.stiki-indonesia.ac.id/login_autentifikasi.php  2> '/dev/null' )
sks=$( curl -L -b cookies.txt "http://akademik.stiki-indonesia.ac.id/index.php?view=transkrip&nim=$1" 2> '/dev/null')
nama=$(
  <<< "${sks}" \
  grep -P -o -e '(?<=<td>)(.*?)(?=</td>)' |
  head -5 | tail -1
)
jurusan=$(
  <<< "${sks}" \
  grep -P -o -e '(?<=<td>)(.*?)(?=</td>)' |
  head -3 | tail -1
)
angkatan=$(
  <<< "${sks}" \
  grep -P -o -e '(?<=<td>)(.*?)(?=</td>)' |
  head -7 | tail -1
)

totalSks=$(
  <<< "${sks}" \
  grep -P -o -e '(?<=<td align="center"><strong>)(.*?)(?=</strong></td>)'|
  head -n 1
)
nilai=$(
  <<< "${sks}" \
  grep -P -o -e '(?<=<td align="center"><strong>)(.*?)(?=</strong></td>)'|
  tail -n 1
)

ip=$(echo "scale=2; $nilai / $totalSks" | bc -l )

echo "--------------"
printf  '%s\n' "Nama 		: ${nama}" "Jurusan 	: ${jurusan}" "Angkatan 	: ${angkatan}"
echo "--------------"
printf  '%s\n' "Total SKS 	: ${totalSks}"  "IP 		: ${ip}"
