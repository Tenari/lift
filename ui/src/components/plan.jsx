import React from 'react';
import { ExerciseForm } from './ExerciseForm';
import {styles} from '../assets/style_config';
import {config} from '../config';

export function Plan({exercises, plan, refreshPlans}) {
  const edit = false;
  const [editing, setEditing] = React.useState(false);
  const [temp, setTemp] = React.useState(plan);
  React.useEffect(() => {
    setTemp(plan);
  }, [plan]);

  console.log(plan);
  if (plan && plan.name) {
    console.log(exercises);
    let exSummary = plan.exercises.map(e => {
      const ex = exercises.find(ex => ex.id === e.id);
      return ex.name +' '+ e.sets + 'x' + e.reps;
    }).join('; ');
    if (exSummary.length > 60) {
      exSummary = plan.exercises.length + ' exercise(s)';
    }
    return <div className={styles.exercise.container}>
      {edit && <button className={styles.goodMehFn(!editing) + styles.smbtn} onClick={() => setEditing(!editing)}>{editing ? 'cancel' : 'edit'}</button>}
      {!editing && <div>
        <p>{plan.name}</p>
        <p>{exSummary}</p>
      </div>}
      {edit && <ExerciseForm
        visible={editing}
        exercise={temp}
        set={setTemp}
        pokeFn={editExercise}
        refreshExercises={refreshExercises}
        cb={() => setEditing(false)}
      />}
    </div>;
  }
  return null;
}

