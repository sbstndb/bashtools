## Objectif :enregistrer par cpu (logique?) son activité "user" au cours du temps. 
## typiquement, lors de l'execution d'un cas elsA, afin d'avoir une idee de la repartition de la charge cpu. 
## Note : une version mémoire existe/va exister


## Nom du fichier d'enregistrement
if [ $# -eq 1 ]; then
	output_file=$1
	if [ ! -d "$(dirname "$output_file")" ]; then
	   mkdir -p "$(dirname "$output_file")"
   	fi

else
	output_file="pstat_result.txt"
fi

## intervale de mesure (a rendre configurable?)
interval=5

echo "Timestamp || Core1 Core2 Core3 Core4 Core5 Core6 ..." > "$output_file"

export condition=true
while $contition
do
	timestamp=$(date "+%Y-%m-%d %H:%M:%S")
	core_usage=$(mpstat -P ALL 1 1 | awk '/[0-9]/ {printf("%s ", $3)}')
	echo "$core_usage"
	echo "$timestamp $core_usage" >> "$output_file"
 	sleep $interval
done
