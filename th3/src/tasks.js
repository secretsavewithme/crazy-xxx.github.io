import { random } from 'lodash'

const headers = [
  'Challenge 01. Starting it easy',
  'Challenge 02. Getting into action',
  'Challenge 03. Short but sweet',
  '',
  '',
  '',
  '',
  '',
]

const intros = [
  "So you decided to be a throat whore today, you will get more than you expect, but you should start slowly, enjoy it.",
  "Bored from licking and not getting full candy? Dont worry bitch, things are getting more interesting.",
  "This challenge will provide you more spit, don't swallow it, leave it in your mouth, all dripped spit must end in the bowl from now on. Obedient girls swallow only cum, but keep spit for the show.",
  "",
  "",
  "",
  "",
]

const tasks =  [
  [ // 1
  'lick the dildo 10 times',
  'lick the dildo 15 times',
  'put the head of your dildo in your mouth for 10 seconds',
  'put the head of your dildo in your mouth for 15 seconds',
  'lick the dildo 10 times and put the head of your dildo in your mouth for 10 seconds',
  'lick the dildo 15 times and put the head of your dildo in your mouth for 15 seconds' ],

  [ // 2
  'swallow it until you get tears in eyes',
  'slowly swallow it down your throat 1 time',
  'slowly swallow it down your throat 2 times',
  'slowly swallow it down your throat 3 times',
  'quickly swallow it down your throat 3 times',
  'slowly swallow it down your throat 3 times then quickly swallow it down your throat 3 times', ],

  [ // 3
  'push it down your throat and leave it there for 3 seconds',
  'push it down your throat and rotate it 360 degrees. ',
  'push it in as fast as you can and leave it there for 10 seconds',
  'push it in as fast as you can and rotate it 360 degrees two times',
  'push it into you throat and out as fast you can 3 times, repeat it 3 times',
  'All of it, with short breaks: {ALL}', ],
]

const punishments = [
  null,
  null,
  {intro: 'If you swallowed any spit, or it fell on floor...', task: 5},
  '',
  '',
]

const randIndex = (difficulty) => {
  if ('lite' === difficulty) {
    return random(4)
  }
  else {
    const r = random(5) + difficulty
    return r < 0 ? 0 : r > 5 ? 5 : r
  }
}

const withAllAppended = (task, curTasks) =>
  task.replace("{ALL}", "\n" + curTasks.slice(0, 5).join("\n"))

const postProcess = (curTasks, index) =>
  withAllAppended(curTasks[index], curTasks)

const preparePunishment = (punishment, curTasks) => {
  if (punishment) {
    if (punishment.task) {
      return { ...punishment, text: postProcess(curTasks, punishment.task) }
    }
  }
}

const nextTask = (num, difficulty) => {
  const index = randIndex(difficulty)
  const task = `[${index + 1}] ${postProcess(tasks[num], index)}`
  return {
    header: headers[num],
    intro: intros[num],
    task,
    punishment: preparePunishment(punishments[num], tasks[num])
  }
}

export default nextTask
