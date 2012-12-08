shellPrompt := { state =>
 "sbt (%s)> ".format(Project.extract(state).currentProject.id)
}

List(
  ("c", "compile"),
  ("cc", "~compile"),
  ("r", "reload"),
  ("rm", "run-main"),
  ("p", "project"),
  ("cn", "console"),
  ("up", "update")
).map({ case (k,v) => addCommandAlias(k,v) }).reduce(_ ++ _)
