shellPrompt := { state =>
 "sbt (%s)$ ".format(Project.extract(state).currentProject.id)
}

List(
  ("c", "test:compile"),
  ("tc", "test:compile"),
  ("cc", "~test:compile"),
  ("r", "reload"),
  ("u", "run"),
  ("uu", "~run"),
  ("ru", "run"),
  ("rm", "run-main"),
  ("p", "project"),
  ("cn", "console"),
  ("up", "update"),
  ("pa", "project autograph"),
  ("pd", "project dash")
).map({ case (k,v) => addCommandAlias(k,v) }).reduce(_ ++ _)
