import React from 'react';
import { FilterBtn } from '../components/FilterBtn';
import { config } from '../config';
import { styles } from '../assets/style_config';
import { addExercise } from '../helpers';

export function SettingsPage() {
  const [settings, setSettings] = React.useState(null);

  React.useEffect(async () => {
    const settings = null; // scry settings
    setSettings(settings);
  }, []);

  if (!settings) return <p>Loading...</p>
  return <div className="p-7">
    <p className="text-large text-center font-semibold">Your settings</p>
    <ul>
      <li>
        Default weight unit:
        <select value={exercise.mode} onChange={(e) => set({...exercise, mode: e.target.value})}>
          {Object.keys(config.exerciseModes).map((t) => <option key={t} value={t}>{config.exerciseModes[t]}</option>)}
        </select>
      </li>
    </ul>
  </div>
}
