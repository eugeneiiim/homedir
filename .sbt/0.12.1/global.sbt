shellPrompt := { state =>
 "sbt (%s)> ".format(Project.extract(state).currentProject.id)
}

List(
  ("c", "compile"),
  ("cc", "~compile"),
  ("r", "reload"),
  ("u", "run"),
  ("uu", "~run"),
  ("ru", "run"),
  ("rm", "run-main"),
  ("p", "project"),
  ("cn", "console"),
  ("up", "update")
).map({ case (k,v) => addCommandAlias(k,v) }).reduce(_ ++ _)
