use IO, List, Map;

config const debug = false;

const Pairs  = ['('=>')', '['=>']', '{'=>'}',  '<'=>'>' ];
const Scores = [')'=>1,   ']'=>2,  '}'=>3, '>'=>4];

iter readlines() {
  var line: string;
  while (stdin.readline(line)) {
    yield line.strip();
  }
}

var navSubSys = readlines();

var scores: list(int, parSafe=true);

forall (command, lineno) in zip(navSubSys, 1..) with (ref scores) {
  var stack: list(string);
  for ch in command {
    if Pairs.domain.contains(ch) then
      stack.append(ch);
    else {
      const tail = stack.last();
      const expected = Pairs[tail];
      if ch == expected then
        stack.pop();
      else {
        stack.clear();
        break;
      }
    }
  }
  if stack.size != 0 {
    var score: int;
    for i in stack.indices by -1 {
      score *= 5;
      score += Scores[Pairs[stack.getValue(i)]];
    }
    scores.append(score);
  }
}
if debug then writeln(scores);
scores.sort();
writeln(scores);
var middle = scores.getValue(scores.size/2);
writeln(middle);
