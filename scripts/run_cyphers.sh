DEFAULT_ENDPOINT=bolt://localhost:7687
ENDPOINT=${NEO4J_URI:-$DEFAULT_ENDPOINT}
USERNAME=${NEO4J_USERNAME:-neo4j}
PASSWORD=${NEO4J_PASSWORD:-dundy13}
CYPHER=${NEO4J_BIN:-$NEO4J_HOME/bin}
CYPHERS=$SETUP_DIR/cyphers
REFDATA=$SETUP_DIR/reference_data

echo "Endpoint: "$ENDPOINT
echo "Username: "$USERNAME
echo "Password: "$PASSWORD

export cypher_shell="$CYPHER/cypher-shell"

function run_cypher {
    echo " "
    echo "----------------------------------------------"
    echo "Running $1:"
    echo " "
    cat "$CYPHERS/$1"
    cat "$CYPHERS/$1" | "$cypher_shell" -a "$ENDPOINT" -u "$USERNAME" -p "$PASSWORD"
}

if [ "$1" = "-init" ]; then
  run_cypher 00a-Init.cypher
fi

run_cypher 00d-GeoNamesContinent.cypher
run_cypher 00e-GeoNamesCountry.cypher
run_cypher 00f-GeoNamesAdmin1.cypher
run_cypher 00g-GeoNamesAdmin2.cypher
run_cypher 00h-GeoNamesCity.cypher
run_cypher 00i-GeoNamesUN.cypher
