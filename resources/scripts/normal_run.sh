pre_start_action() {
  : # No-op
}

post_start_action() {
  : # No-op
  cd /root/wisemapping-v3.0.2
  java -Dorg.apache.jasper.compiler.disablejsr199=true -jar start.jar
}
