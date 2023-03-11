import React from 'react';
import { ongoingWorkout, startNewWorkout } from '../helpers';

export function RootPage({history, api, refreshHistory}) {
  const [loading, setLoading] = React.useState(false);
  if (loading) return <p>Loading...</p>;

  const workout = ongoingWorkout(history);
  if (workout) {
    console.log(workout);
    return <div className="p-7 flex justify-center">
      <p>workout started on {new Date(workout.start).toDateString()}</p>
      <ol>
        {workout.lifts.map(l => {
          return <p>a lift</p>
        })}
        <button className="bg-white rounded-md shadow-md p-1" onClick={() => console.log('TODO add lift poke')}>Add lift</button>
      </ol>
    </div>
  } else {
    return <div className="p-7 flex justify-center">
      <button className="bg-white rounded-md shadow-md p-1" onClick={async () => {
        setLoading(true);
        await startNewWorkout(api);
        await refreshHistory();
        setLoading(false);
      }}>Start new workout</button>
    </div>
  }
}
