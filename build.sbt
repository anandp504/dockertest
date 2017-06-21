//import NativePackagerHelper._
//import com.typesafe.sbt.packager.docker._
//import sbtdocker.DockerKeys._

enablePlugins(JavaAppPackaging)
//enablePlugins(UniversalPlugin)
//enablePlugins(DockerPlugin)

// Assembly settings

mainClass in assembly := Some("com.collective.docker.AppEntry")

test in assembly := {}

// SBT Native Packager settings

name in Universal := "Docker Test App"

packageName in Universal := "dockertest-app"

daemonUser := "root"

lazy val dockerSettings = Seq(
  // things the docker file generation depends on are listed here
  dockerfile in docker := {
    new sbtdocker.mutable.Dockerfile {
      copy(baseDirectory(_ / "config" / "docker.conf").value, file("Dockerfile"))
    }
  }
)
    