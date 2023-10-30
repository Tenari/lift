import React from 'react';
import { Plan } from '../components/plan';

export function PlanPage({history, exercises, plans}) {
  if (!history) return null;
  if (!exercises) return null;

  return <div>
    <p>Plan a future workout by defining the exercises you'd like to do:</p>
    <ul>
      {plans.map( p => <Plan plan={p} exercises={exercises}/>)}
    </ul>
  </div>;
}

