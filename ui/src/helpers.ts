export const ongoingWorkout = (history) => {
  return history && history[0] && history[0].end === null ? history[0] : false;
}
export async function startNewWorkout(api) {
  return await api.poke({
    app: 'lift',
    mark: 'lift-action',
    json: {
      "start-workout": "~"+api.ship,
    },
  });
}

export async function endCurrentWorkout(api) {
  return await api.poke({
    app: 'lift',
    mark: 'lift-action',
    json: {
      "end-workout": "~"+api.ship,
    },
  });
}


export async function addLiftToWorkout(api, id) {
  return await api.poke({
    app: 'lift',
    mark: 'lift-action',
    json: {
      "add-lift": id,
    },
  });
}

export async function getAgentState(api) {
  const history = await api.scry({app: "lift", path: "/history"});
  const exercises = await api.scry({app: "lift", path: "/exercises"});
  return {history, exercises};
}

