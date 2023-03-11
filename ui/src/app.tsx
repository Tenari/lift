import React, { useEffect, useState } from 'react';
import Urbit from '@urbit/http-api';
import { RootPage } from './pages/root';
import { ExercisesPage } from './pages/exercises';
import { NavLink } from './components/navlink';
import { getAgentState } from './helpers';

const api = new Urbit('', '', window.desk);
api.ship = window.ship;

export function App() {
  const [page, setPage] = useState('root');
  const [hist, setHist] = useState(null);
  const [exercises, setExercises] = useState(null);

  useEffect(() => {
    async function init() {
      const { history, exercises } = await getAgentState(api);
      setHist(history);
      setExercises(exercises);
    }

    init();
  }, []);

  async function refreshHistory() {
    const h = await api.scry({app: "lift", path: "/history"});
    setHist(h);
  }
  if (!hist && !exercises) return <p>Loading...</p>;

  const PAGES = {
    'root': () => <RootPage api={api} history={hist} refreshHistory={refreshHistory}/>,
    'exercises': () => <ExercisesPage exercises={exercises}/>,
  }

  console.log(hist, exercises);
  return (
    <main className="">
      <nav className="flex bg-gray-400 justify-between p-4">
        <NavLink set={setPage} page="root" label="track"/>
        <NavLink set={setPage} page="plan"/>
        <NavLink set={setPage} page="history"/>
        <NavLink set={setPage} page="exercises"/>
        <NavLink set={setPage} page="settings"/>
      </nav>
      {PAGES[page]()}
    </main>
  );
}
