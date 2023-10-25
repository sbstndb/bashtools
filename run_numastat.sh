## Objectif :enregistrer l'utilisation mémoire  au cours du temps. 
## typiquement, lors de l'execution d'un cas elsA, afin d'avoir une idee de la repartition de la charge mémoire 
## Note : une version utilisation cpu existe


## Nom du fichier d'enregistrement
if [ $# -eq 1 ]; then
	output_file=$1
	if [ ! -d "$(dirname "$output_file")" ]; then
	   mkdir -p "$(dirname "$output_file")"
   	fi

else
	output_file="numastat_result.txt"
fi

## intervale de mesure (a rendre configurable?)
interval=5
EXE="elsA.x"

echo "Timestamp || NUMA1, NUMA2, NUMA3, NUMA4, Total ..." > "$output_file"

export condition=true
while $contition
do
	timestamp=$(date "+%Y-%m-%d %H:%M:%S")
	#core_usage=$(mpstat -P ALL 1 1 | awk '/[0-9]/ {printf("%s ", $3)}')
	memory_usage=$(numastat -p $EXE | awk '/Total/ {print $2, $3, $4, $5, $6}') ## if 4 Numa Nodes ...
	echo "$timestamp $memory_usage" >> "$output_file"
 	sleep $interval
done

