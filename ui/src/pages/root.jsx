import React from 'react';
import { Workout } from '../components/workout';
import {
  ongoingWorkout,
  addLiftToWorkout,
  startNewWorkout,
  endCurrentWorkout,
} from '../helpers';

export function RootPage({history, refreshHistory, exercises}) {
  const [addLift, setAddLift] = React.useState(false);
  const [loading, setLoading] = React.useState(false);
  if (loading) return <p>Loading...</p>;

  const workout = ongoingWorkout(history);
  if (workout) {
    console.log(workout, addLift);
    return <div className="p-7 container mx-auto">
      <Workout workout={workout} exercises={exercises} edit={true} refreshHistory={refreshHistory}/>
      <div>
        <button className="bg-white rounded-md shadow-md p-1" onClick={() => setAddLift(!!addLift ? false : {} )}>Add lift</button>
        {addLift && <div className="bg-white m-1 p-1 rounded-md">
          Lift:
          <select value={addLift.id} onChange={(e) => setAddLift({id: e.target.value})}>
            <option value="">--</option>
            {exercises.map(e=><option key={e.id} value={e.id}>{e.name}</option>)}
          </select>
          <button className="bg-green-200 disabled:bg-gray-400 rounded-md shadow-md p-1 diabled:cursor-not-allowed" disabled={!(addLift && addLift.id)} onClick={async () => {
            setLoading(true);
            await addLiftToWorkout(addLift.id)
            await refreshHistory();
            setAddLift(null);
            setLoading(false);
          }}>Add</button>
        </div>}
      </div>
      <button className="bg-red-600 text-center p-6 rounded-lg border-red-700 mx-auto container m-3 text-white text-xl" onClick={async () => {
        setLoading(true);
        await endCurrentWorkout();
        await refreshHistory();
        setLoading(false);
      }}>End Workout</button>
    </div>
  } else {
    return <div className="p-7 flex justify-center">
      <button className="bg-white rounded-md shadow-md p-1" onClick={async () => {
        setLoading(true);
        await startNewWorkout();
        await refreshHistory();
        setLoading(false);
      }}>Start new workout</button>
    </div>
  }
}
