function dpf -d 'docker ps with format'
  docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"
  docker ps | wc -l
end
