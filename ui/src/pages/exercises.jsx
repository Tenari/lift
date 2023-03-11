import React from 'react';
import { Exercise } from '../components/exercise';

export function ExercisesPage({exercises}) {
  if (!exercises) return null;

  return <div className="p-7">
    <p className="text-large text-center font-semibold">Your exercise library</p>
    <ul className="flex flex-wrap justify-center">
      {exercises.map(e => <Exercise key={e.id} ex={e}/>)}
    </ul>
  </div>
}
