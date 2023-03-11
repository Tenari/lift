import React from 'react';
import { Exercise } from '../components/exercise';

const FilterBtn = ({setEq, eq, value, label}) => {
  const defaultFilterButton = " p-1 rounded-sm m-1";
  return <button
    className={(eq === value ? "bg-green-200" : "bg-white") + defaultFilterButton}
    onClick={() => (eq === value ? setEq(false) : setEq(value))}>
    {label}
  </button>;
};

export function ExercisesPage({exercises}) {
  const [eq, setEq] = React.useState(false);
  if (!exercises) return null;

  return <div className="p-7">
    <p className="text-large text-center font-semibold">Your exercise library</p>
    <div>
      <FilterBtn setEq={setEq} eq={eq} value="bb" label="Barbell" />
      <FilterBtn setEq={setEq} eq={eq} value="db" label="Dumbbell" />
      <FilterBtn setEq={setEq} eq={eq} value="x" label="Body" />
    </div>
    <ul className="flex flex-wrap justify-center">
      {exercises.filter((e) => !eq || e.equipment === eq).map(e => <Exercise key={e.id} ex={e}/>)}
    </ul>
  </div>
}
