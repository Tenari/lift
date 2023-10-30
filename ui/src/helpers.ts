export const ongoingWorkout = (history) => {
  return history && history[0] && history[0].end === null ? history[0] : false;
}
const poke = async (data) => {
  return await window.api.poke({
    app: 'lift',
    mark: 'lift-action',
    json: data,
  });
};

export async function startNewWorkout() {
  return await poke({
    "start-workout": "~"+window.api.ship,
  });
}

export async function endCurrentWorkout() {
  return await poke({
    "end-workout": "~"+window.api.ship,
  });
}

export async function addLiftToWorkout(id) {
  return await poke({
    "add-lift": id,
  });
}

export async function addSetToLift(data) {
  return await poke({
    "add-set": data,
  });
}

export async function editExercise(data) {
  return await poke({
    "edit-exercise": data,
  });
}

export async function addExercise(data) {
  data.id = "/~zod/0"; // this will be generate by hoon so we just overwrite to some valid value
  return await poke({
    "add-exercise": data,
  });
}

export async function getAgentState() {
  const plans = await window.api.scry({app: "lift", path: "/plans"});
  const history = await window.api.scry({app: "lift", path: "/history"});
  const exercises = await window.api.scry({app: "lift", path: "/exercises"});
  return {history, exercises, plans};
}

