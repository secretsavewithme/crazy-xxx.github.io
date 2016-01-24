Tasks = [
  {desc: 'lick it with your tongue', min: 10, max: 30},
  {desc: 'suck it with your mouth', min: 10, max: 30},
  {desc: 'fuck your open mouth', min: 10, max: 30},
  {desc: 'stroke it with your hand', min: 10, max: 30},
  {desc: 'deepthroat on it', min: 10, max: 30},
  {desc: 'gag on it', min: 10, max: 30},
  {desc: 'fuck your throat', min: 10, max: 30},
  {desc: 'keep it in your throat', min: 3, max: 10},
  {desc: 'go deep on it', min: 3, max: 10},
  {desc: 'slap your face', min: 5, max: 15},
  {desc: 'wipe the spit on your face', min: 5, max: 15},
  {desc: 'moan like a whore', min: 5, max: 15},
]

generateTask = ->
  task = _.sample(Tasks)
  time = _.random(task.min, task.max)
  dup(task, time: time, elapsed: time)
