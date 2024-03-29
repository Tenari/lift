const NULL_DATE = 946684800000;
const api = new UrbitHttpApi.Urbit("", "", "lift");
api.ship = window.ship;
async function getAgentState() {
  var h = await api.scry({app: "lift", path: "/history"});
  State.history = h.map( w => ({
    lifts: w.lifts,
    start: new Date(w.start),
    end: w.end === NULL_DATE ? null : new Date(w.end)
  }))
  var es = await api.scry({app: "lift", path: "/exercises"});
  State.exercises = {};

  es.map(e => {
    e.id = ""+e.id.num + e.id.ship;
    return e;
  }).forEach(e => {
    State.exercises[e.id] = e;
  })
}
let State = {page: "root", history: [], exercises: [], plans: []};
const setState = (key, val) => {
  console.log('setting state', key, val);
  State[key] = val;
  const stateChangedEvent = new CustomEvent("statechanged", {detail:{ key, val }});
  window.dispatchEvent(stateChangedEvent);
}; 
function startNewWorkout() {
  api.poke({
    app: 'lift',
    mark: 'lift-action',
    json: {
      "start-workout": "~"+api.ship,
    },
  }).then(r=>{
    console.log('r',r);
  })
  // TODO call to urbit, get response of new workout object
  State.history.push({
    lifts: [],
    start: new Date(),
    end: null
  })
}

function showList(elem, items, inner) {
  let listHTML = "";
  for (i of items) {
    listHTML += "<li>"+(inner(i))+"</li>";
  }
  elem.innerHTML = listHTML;
}
function renderExercise(ex) {
  return (ex.name||"")+" <img width='100' src=\""+ex.img+"\"/></li>";
}

const Renderers = {
  "root" : () => {
    // if there is a workout ongoing
    if (State.history.length > 0 && State.history[0].end === null) {
      setState('page', "ongoing-workout");
    } else {
      const page = document.querySelector(".page.start-workout");
      page.classList.toggle("hide", false);
      page.querySelector(".start-planned-workout").classList.toggle("hide", State.plans.length == 0);
    }
  },
  "ongoing-workout" : () => {
    // if there is not a workout ongoing go to start-workout page
    if (State.history.length === 0 || State.history[0].end !== null) {
      setState('page', "root");
      return;
    }

    const page = document.querySelector(".page.ongoing-workout");
    page.classList.toggle("hide", false);
    const workout = State.history[0];
    page.querySelector("span").innerHTML = workout.start.toLocaleTimeString();

    showList(page.querySelector("ul.lifts-in-current-workout"), workout.lifts, function(lift) {
      return renderExercise(State.exercises[lift.id]);
    })

  },
  "exercises" : () => {
    const page = document.querySelector(".page.exercises");
    page.classList.toggle("hide", false);

    showList(page.querySelector("ul.exercise-list"), Object.values(State.exercises), function(ex) {
      return renderExercise(ex);
    })
  },
  "history" : () => {
    const page = document.querySelector(".page.history");
    page.classList.toggle("hide", false);

    showList(page.querySelector("ul.workouts-list"), State.history, function(workout) {
      return workout.start.toDateString()
    })
  },
};

const setup = [
  // setup top links
  function() {
    const links = document.querySelectorAll(".header a");
    links.forEach(link => {
      link.addEventListener('click', (event) => {
        event.preventDefault();
        setState('page', event.target.href.split('#')[1]);
      });
    })
  },
  // setup start-workout page
  function() {
    const freeformBtn = document.querySelector(".page.start-workout button.start-freeform-workout");
    freeformBtn.addEventListener('click', (event) => {
      event.preventDefault();
      startNewWorkout();
      setState('page', "ongoing-workout");
    });
  },
  // setup ongoing-workout page
  function() {
    const btn = document.querySelector(".page.ongoing-workout button.add-new-lift-to-workout");
    btn.addEventListener('click', (event) => {
      event.preventDefault();
      // TODO tell urbit about this
      State.history[0].lifts.push({id: 1, sets: [], details: {}});
      render("ongoing-workout");
    });
  },
];

function render(path) {
  if (Renderers[path]) {
    Array.from(document.getElementsByClassName("page")).forEach(page => {
      page.classList.toggle('hide', true);
    })
    Renderers[path]();
  }
}

document.addEventListener("DOMContentLoaded", () => {
  getAgentState();

  render(State.page);
  window.addEventListener('statechanged', (event) => {
    console.log(event);
    if (event.detail.key === 'page') {
      render(event.detail.val);
    }
  });

  for (fn of setup) {
    fn();
  }
});
