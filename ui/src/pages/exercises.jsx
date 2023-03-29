import React from 'react';
import { Exercise } from '../components/exercise';
import { FilterBtn } from '../components/FilterBtn';
import { ExerciseForm } from '../components/ExerciseForm';
import { config } from '../config';
import { styles } from '../assets/style_config';
import { addExercise } from '../helpers';

export function ExercisesPage({exercises, refreshExercises}) {
  const [adding, setAdding] = React.useState(false);
  const [eq, setEq] = React.useState(false);
  const [ex, setEx] = React.useState({...config.defaultExercise});
  if (!exercises) return null;
  const cb = () => {
    setAdding(false);
    setEx({...config.defaultExercise});
  }

  return <div className="p-7">
    <p className="text-large text-center font-semibold">Your exercise library</p>
    <div>
      {Object.keys(config.equipmentTypes).map(t => <FilterBtn setEq={setEq} eq={eq} value={t} label={config.equipmentTypes[t]} />)}
      <div>
        <button className={styles.goodMehFn(!adding) + styles.smbtn} onClick={()=>setAdding(!adding)}>{adding ? 'cancel' : 'Add Exercise'}</button>
        {adding && <div className={styles.container}>
          <ExerciseForm visible={adding} exercise={ex} set={setEx} pokeFn={addExercise} refreshExercises={refreshExercises} cb={cb} />
        </div>}
      </div>
    </div>
    <ul className="flex flex-wrap justify-center">
      {exercises.filter((e) => !eq || e.equ === eq).map(e => <Exercise key={e.id} ex={e} edit={true} refreshExercises={refreshExercises} />)}
    </ul>
  </div>
}
