import React, { useEffect, useState } from 'react';
import Urbit from '@urbit/http-api';
import { RootPage } from './pages/root';
import { ExercisesPage } from './pages/exercises';
import { HistoryPage } from './pages/history';
import { PlanPage } from './pages/plan';
import { NavLink } from './components/navlink';
import { getAgentState } from './helpers';

const api = new Urbit('', '', window.desk);
api.ship = window.ship;
window.api = api;

export function App() {
  const [page, setPage] = useState('root');
  const [hist, setHist] = useState(null);
  const [exercises, setExercises] = useState(null);
  const [plans, setPlans] = useState(null);

  useEffect(() => {
    async function init() {
      const { history, exercises, plans } = await getAgentState();
      setHist(history);
      setExercises(exercises);
      setPlans(plans);
    }

    init();
  }, []);

  async function refreshHistory() {
    const h = await api.scry({app: "lift", path: "/history"});
    setHist(h);
  }
  async function refreshExercises() {
    const e = await api.scry({app: "lift", path: "/exercises"});
    setExercises(e);
  }
  if (!hist && !exercises) return <p>Loading...</p>;

  const PAGES = {
    'root': () => <RootPage history={hist} refreshHistory={refreshHistory} exercises={exercises}/>,
    'exercises': () => <ExercisesPage exercises={exercises} refreshExercises={refreshExercises} />,
    'history': () => <HistoryPage history={hist} exercises={exercises}/>,
    'plan': () => <PlanPage history={hist} exercises={exercises} plans={plans}/>,
  }

  console.log(hist, exercises, plans);
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
