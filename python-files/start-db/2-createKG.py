import os
import time
from pathlib import Path

NEO4J_HOME = Path(os.getenv('NEO4J_HOME'))
print(NEO4J_HOME)

status = !"$NEO4J_HOME"/bin/neo4j status
status = str(status)
while not 'Neo4j is running' in status:
    !"$NEO4J_HOME"/bin/neo4j start
    time.sleep(30)
    status = !"$NEO4J_HOME"/bin/neo4j status
    status = str(status)
    print(status)

# wait until neo4j is ready to receive requests
time.sleep(60)

start = time.time()

!../../scripts/run_cyphers.sh -init # start with a clean database and create new indices and constraints

end = time.time()
print('time:', end-start)

!"$NEO4J_HOME"/bin/neo4j stop