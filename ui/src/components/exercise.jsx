import React from 'react';
import { ExerciseForm } from './ExerciseForm';
import {styles} from '../assets/style_config';
import {config} from '../config';
import {
  editExercise,
} from '../helpers';

export function Exercise({ex, edit, refreshExercises}) {
  const [editing, setEditing] = React.useState(false);
  const [temp, setTemp] = React.useState(ex);
  React.useEffect(() => {
    setTemp(ex);
  }, [ex]);

  console.log(ex);
  return <div className={styles.exercise.container}>
    {edit && <button className={styles.goodMehFn(!editing) + styles.smbtn} onClick={() => setEditing(!editing)}>{editing ? 'cancel' : 'edit'}</button>}
    {!editing && <div>
      <p>{ex.name}</p>
      <img src={ex.img} className="max-h-36"/>
    </div>}
    {edit && <ExerciseForm
      visible={editing}
      exercise={temp}
      set={setTemp}
      pokeFn={editExercise}
      refreshExercises={refreshExercises}
      cb={() => setEditing(false)}
    />}
  </div>
}

