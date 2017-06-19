import {isNumber, max, random} from 'lodash'

const headers = [
  'Challenge 01. Starting it easy',
  'Challenge 02. Getting into action',
  'Challenge 03. Short but sweet',
  'Challenge 04. Dripping mess',
  'Challenge 05. Breath control',
  'Challenge 06. First endurance test',
  'Challenge 07. Break time',
  'Challenge 08. Pure throatfuck',
  '',
  '',
  '',
  '',
]

const intros = [
  "So you decided to be a throat whore today, you will get more than you expect, but you should start slowly, enjoy it.",
  "Bored from licking and not getting full candy? Dont worry bitch, things are getting more interesting.",
  "This challenge will provide you more spit, don't swallow it, leave it in your mouth, all dripped spit must end in the bowl from now on. " +
    "Obedient girls swallow only cum, but keep spit for the show.",
  "Put that mess on your face slut, you are about get nasty and degraded!",
  "When out of air, you will know what it truly means to submit like a slave.",
  "You will be throated like a whore.",
  "Right now you are willing to do anything else than having a dildo rape your throat.",
  "Show me how good are you at the very basic discipline of blowjob. I will make a spit factory out of you.",
  "",
  "",
]

const tasks = [
  [ // 1
    'lick the dildo 10 times',
    'lick the dildo 15 times',
    'put the head of your dildo in your mouth for 10 seconds',
    'put the head of your dildo in your mouth for 15 seconds',
    'lick the dildo 10 times and put the head of your dildo in your mouth for 10 seconds',
    'lick the dildo 15 times and put the head of your dildo in your mouth for 15 seconds',
  ],
  [ // 2
    'swallow it until you get tears in eyes',
    'slowly swallow it down your throat 1 time',
    'slowly swallow it down your throat 2 times',
    'slowly swallow it down your throat 3 times',
    'quickly swallow it down your throat 3 times',
    'slowly swallow it down your throat 3 times then quickly swallow it down your throat 3 times',
  ],
  [ // 3
    'push it down your throat and leave it there for 3 seconds',
    'push it down your throat and rotate it 360 degrees. ',
    'push it in as fast as you can and leave it there for 10 seconds',
    'push it in as fast as you can and rotate it 360 degrees two times',
    'push it into you throat and out as fast you can 3 times, repeat it 3 times',
    'All of it, with short breaks: {ALL}',
  ],
  [ // 4
    "Sit down, drool the spit and try to take it back to your mouth without using your hands. A little tip: imagine you're drinking with a straw",
    "Get on your back with your neck on the border of your bed, drool the spit and try to take it back to your mouth without using your hands. " +
      "A little tip: imagine you're drinking with a straw",
    "Put all that spit onto your genitals and over the tits",
    "Get on your back with your neck on the border of your bed, swallow dildo then look how it drips on your face, 15 times, don't blink",
    "Get on your back with your neck on the border of your bed, and spit it all over your face, with closed eyes",
    "Drink the spit",
  ],
  [ // 5
    "you have to hold it in your throat for 8 seconds {TIMER: 8}",
    "you have to hold it in your throat for 10 seconds, smack your face once during this {TIMER: 10}",
    "you have to hold it in your throat for 12 seconds, smack your face once during this {TIMER: 12}",
    "you have to hold it in your throat for 18 seconds, smack your face twice during this {TIMER: 18}",
    "you have to hold it in your throat for 24 seconds, smack your face twice during this {TIMER: 24}",
    "you have to hold it in your throat for 30 seconds, smack your face 3 times during this {TIMER: 30}",
  ],
  [ // 6
    "Fuck your throat with your dildo 10 times, then hold it in for 5 seconds. Do this 3 times in a row. Take a break only to spit into the bowl",
    "Fuck your throat with your dildo 12 times, then hold it in for 6 seconds. Do this 3 times in a row. Take a break only to spit into the bowl",
    "Fuck your throat with your dildo 16 times, then hold it in for 8 seconds. Do this 3 times in a row. Take a break only to spit into the bowl",
    "Fuck your throat with your dildo 18 times, then hold it in for 9 seconds. Do this 3 times in a row. Take a break only to spit into the bowl",
    "Fuck your throat with your dildo 10 times, then hold it in for 10 seconds. Do this 3 times in a row, must keep spit in your mouth, no break",
    "Fuck your throat with your dildo 10 times, then hold it in for 20 seconds. Do this 5 times in a row, must keep spit in your mouth, no break",
  ],
  [ // 7
    "Get on your back with your neck on the border of your bed, drool the spit and try to take it back to your mouth without using your hands. " +
      "A little tip: imagine you're drinking with a straw",
    "Get on your back with your neck on the border of your bed and spit it all over your face, with closed eyes",
    "Take some spit and drool it on your open eyes with your hand",
    "Take all that spit play with it for more than 2 minutes, get in anywhere on face, except hair",
    "Take some spit and drool it on your open eyes with your hand, play with it 3 minutes",
    "Take all that spit play with it for more than 5 minutes, get in anywhere on face, except hair",
  ],
  [ // 8
    "Push the dildo as deep as you can and out of the mouth fast 30 times. Only pause to spit into the bowl, then resume immediately.",
    "Push the dildo as deep as you can and out of the mouth fast 60 times. Only pause to spit into the bowl, then resume immediately.",
    "Push the dildo as deep as you can and out of the mouth fast 90 times. Only pause to spit into the bowl, then resume immediately.",
    "Push the dildo as deep as you can and out of the mouth fast 120 times. Only pause to spit into the bowl, then resume immediately.",
    "Push the dildo as deep as you can and out of the mouth fast 100 times. Take a break to catch your breath, then do it again.",
    "Push the dildo as deep as you can and out of the mouth fast 100 times. Take a break to catch your breath, then do it again TWICE.",
  ],
  [ // 9
  ],
  [ // 10
  ],
  [ // 11
  ],
  [ // 12
  ],
  [ // 13
  ],
]

const punishments = [
  null,
  null,
  {intro: "If you swallowed any spit, or it fell on the floor...", task: 5},
  {intro: "If you didn't create enough spit...", text: "swallow the dildo 30 times and repeat the challenge"},
  {intro: "If you didn't hold it in long enough...", easier: 1},
  {intro: "Smack your face for every break longer than 6 seconds."},
  {intro: "Didn't get enough time to rest? Not your fault, life is not fair. Start next challenge immediately!", ifTask: 0},
  {intro: "Gag yourself for every break longer than 4 seconds."},
  {},
  {},
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

const extractTimer = (mightContainTimer) => {
  let timer
  const task = mightContainTimer.replace(/\s*{TIMER: (\d+)}\s*/, (_, num) => {
    timer = +num
    return ''
  })
  return {task, timer}
}

const prependIndex = (task, index) => `[${index + 1}] ${task}`

const prepareTask = (curTasks, index) =>
  extractTimer(
    prependIndex(
      withAllAppended(curTasks[index], curTasks), index))

const preparePunishment = (punishment, curTasks, index) => {
  if (punishment) {
    if (punishment.task) {
      return {...punishment, text: prepareTask(curTasks, punishment.task).task}
    }
    if (punishment.easier) {
      const punishmentTask = prepareTask(curTasks, max([index - 1, 0]))
      return {...punishment, text: punishmentTask.task, timer: punishmentTask.timer}
    }
    if (isNumber(punishment.ifTask) && punishment.ifTask !== index) {
      return {}
    }
    return punishment
  }
}

const nextTask = (num, difficulty) => {
  const index = randIndex(difficulty)
  return {
    header: headers[num],
    intro: intros[num],
    ...prepareTask(tasks[num], index),
    punishment: preparePunishment(punishments[num], tasks[num], index),
  }
}

export default nextTask
