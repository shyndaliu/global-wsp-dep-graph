MATCH (c:Component)
WITH c, 
     size([(c)<-[:DEPENDS_ON]-(:Component) | 1]) AS fanIn, 
     size([(c)-[:DEPENDS_ON]->(:Component) | 1]) AS fanOut

WITH "
| Component | Fan-in | Fan-out | Instability (I) |
|-----------|---------|---------|-----------------|
" AS header, 
     c.name AS component, fanIn, fanOut, 
     ROUND(COALESCE((fanOut * 1.0) / (fanIn + fanOut), 0), 2) AS instability

WITH header, 
     COLLECT("| " + component + 
              " | " + fanIn + 
              " | " + fanOut + 
              " | " + instability + " |") AS rows

RETURN header + 
       REDUCE(output = "", row IN rows | output + row + '\n') AS markdownTable
