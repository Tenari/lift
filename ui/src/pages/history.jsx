import React from 'react';
import { Workout } from '../components/workout';

export function HistoryPage({history, exercises}) {
  if (!history) return null;
  if (!exercises) return null;

  return <ol>
    {history.map(w => <Workout key={w.start} workout={w} exercises={exercises}/>)}
  </ol>;
}

