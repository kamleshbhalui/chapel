use IO, List;

config const debug = false;

var Caves: domain(string);
var Corridors: [Caves] list(string);

var line: string;
while stdin.readline(line) {
  var pair = line.strip().split("-");
  Caves += pair[0];
  Caves += pair[1];
  Corridors[pair[0]].append(pair[1]);
  Corridors[pair[1]].append(pair[0]);
}

if debug {
  forall (n,e) in zip(Caves, Corridors) do
    writeln(n, "-", e);
  writeln();
}

var numPaths: atomic int;
var Visited: [Caves] bool;
var path: list(string);
findAllPaths("start", Visited, path);
writeln(numPaths.read());

proc findAllPaths(room, in Visited, in path) {
  if (room == "end") {
    writeln(path);
    numPaths.add(1);
  } else {
    path.append(room);
    Visited[room] = true;
    forall adjRoom in Corridors[room] do
      if !adjRoom.isLower() || !Visited[adjRoom] then
        findAllPaths(adjRoom, Visited, path);
  }
}
