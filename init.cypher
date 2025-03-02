MATCH (n) DETACH DELETE n;

CREATE 
    (ui:Component {name: 'UI'})-[:DEPENDS_ON]->(lb:Component {name: 'Load Balancer'}),
    (lb)-[:DEPENDS_ON]->(auth:Component {name: 'Auth Server'}),
    (lb)-[:DEPENDS_ON]->(courses:Component {name: '/courses'}),
    (courses)-[:DEPENDS_ON]->(changes:Component {name: '/changes'}),
    (changes)-[:DEPENDS_ON]->(db:Component {name: 'Database'});
