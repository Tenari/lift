import React from 'react';
import { addSetToLift } from '../helpers';

const btnC = " bg-green-200 disabled:bg-gray-400 rounded-md shadow-md p-1 diabled:cursor-not-allowed ";

export function Workout({workout, exercises, edit, refreshHistory}) {
  const [addingSet, setAddingSet] = React.useState(false);
  const [reps, setReps] = React.useState(0);
  const [weight, setWeight] = React.useState(0);
  const [editing, setEditing] = React.useState(false);

  if (!workout) return null;
  if (!exercises) return null;

  return <div className="p-7 container mx-auto">
    <p className="text-center">started on {new Date(workout.start).toLocaleString()}</p>
    {workout.end && <p className="text-center">ended on {new Date(workout.end).toLocaleString()}</p>}
    <ol className="flex flex-wrap justify-center">
      {workout.lifts.map((l, liftIndex) => {
        const ex = exercises.find(e => e.id === l.id);
        const addingSetHere = addingSet === liftIndex;
        return <div key={l.id} className="bg-white rounded-xl shadow-lg p-2 w-1/5 m-2">
          <p>{ex.name}</p>
          <ol>
            Sets:
            {l.sets.map( (s, i) => {
              return <div key={i}>
                reps: {s.reps}
                weight: {s.weight}
              </div>;
            })}
          </ol>
          {edit && <div><button onClick={()=> addingSetHere ? setAddingSet(false) : setAddingSet(liftIndex)} className={btnC + (addingSetHere ? "bg-red-200" : "")}>{addingSetHere ? 'cancel' : 'add set'}</button></div>}
          {editing && addingSetHere && <div>Loading...</div>}
          {addingSetHere && !editing && <div>
            <div>reps: <input type="number" value={reps} onChange={(e) => setReps(parseInt(e.target.value))}/></div>
            <div>weight: <input type="number" value={weight} onChange={(e) => setWeight(parseFloat(e.target.value))}/></div>
            <button className={btnC} onClick={async () => {
              setEditing(true);
              await addSetToLift({
                index: liftIndex,
                set: {
                  mode: 'reps',
                  reps,
                  weight,
                  'weight-unit':'lbs',
                  rir: 1,
                  duration: 0,
                  distance: 0,
                  'distance-unit': 'mi',
                  note: ''
                }
              });
              await refreshHistory();
              setAddingSet(false);
              setEditing(false);
            }}>Add</button>
          </div>}
        </div>
      })}
    </ol>
  </div>;
}
