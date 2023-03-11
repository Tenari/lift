import React from 'react';

export function Workout({workout, exercises}) {
  if (!workout) return null;
  if (!exercises) return null;

  return <div className="p-7 container mx-auto">
    <p className="text-center">started on {new Date(workout.start).toLocaleString()}</p>
    {workout.end && <p className="text-center">ended on {new Date(workout.end).toLocaleString()}</p>}
    <ol className="flex flex-wrap justify-center">
      {workout.lifts.map(l => {
        const ex = exercises.find(e => e.id === l.id);
        return <div key={l.id} className="bg-white rounded-xl shadow-lg p-2 w-1/5 m-2">{ex.name}</div>
      })}
    </ol>
  </div>;
}
