import React from 'react';
import {styles} from '../assets/style_config';
import {config} from '../config';

export function ExerciseForm({visible, exercise, set, pokeFn, refreshExercises, cb}) {
  const [loading, setLoading] = React.useState(false);

  const saveFn = async () => {
    setLoading(true);
    await pokeFn(exercise);
    await refreshExercises();
    setLoading(false);
    cb && cb();
  }

  if (!visible) return null;
  if (loading) return <div>Loading...</div>;

  return <div>
    <div>Name: <input type="text" value={exercise.name} onChange={(e) => set({...exercise, name: e.target.value})} /></div>
    <div>Description: <input type="text" value={exercise.description} onChange={(e) => set({...exercise, description: e.target.value})} /></div>
    <div>Image URL: <input type="text" value={exercise.img} onChange={(e) => set({...exercise, img: e.target.value})} /></div>
    <div>Demonstration URL: <input type="text" value={exercise.demonstration} onChange={(e) => set({...exercise, demonstration: e.target.value})} /></div>
    <div>
      Equipment Type:
      <select value={exercise.equ} onChange={(e) => set({...exercise, equ: e.target.value})}>
        {Object.keys(config.equipmentTypes).map((t) => <option key={t} value={t}>{config.equipmentTypes[t]}</option>)}
      </select>
    </div>
    <div>
      Mode:
      <select value={exercise.mode} onChange={(e) => set({...exercise, mode: e.target.value})}>
        {Object.keys(config.exerciseModes).map((t) => <option key={t} value={t}>{config.exerciseModes[t]}</option>)}
      </select>
    </div>
    <button className={"bg-green-200" + styles.smbtn} onClick={saveFn}>Save</button>
  </div>;
}


