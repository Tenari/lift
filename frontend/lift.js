function getAgentState() {
  // TODO call to urbit for this information
  State = {
    history: [],
    plans: [],
    exercises: {
      1 : {
        id: 1,
        name: "Bench Press",
        mode: "reps",
        equ: "bb",
        img: "https://i.imgur.com/tE9ejXE.jpg",
        description: 'Lay on flat bench; press barbell upward from chest.',
        demonstration: 'https://www.youtube.com/watch?v=vcBig73ojpE'
      }
    }
  }
}

let State = {history: [], exercises: [], plans: []};
function startNewWorkout() {
  // TODO call to urbit, get response of new workout object
  State.history.push({
    lifts: [],
    start: new Date(),
    end: null
  })
}
const Renderers = {
  "" : () => {
    // if there is a workout ongoing
    if (State.history.length > 0 && State.history[0].end === null) {
      window.location.hash = "ongoing-workout";
    } else {
      const page = document.querySelector(".page.start-workout");
      page.classList.toggle("hide", false);
      page.querySelector(".start-planned-workout").classList.toggle("hide", State.plans.length == 0);
    }
  },
  "ongoing-workout" : () => {
    // if there is not a workout ongoing go to start-workout page
    if (State.history.length === 0 || State.history[0].end !== null) {
      window.location.hash = "";
      return;
    }

    const page = document.querySelector(".page.ongoing-workout");
    page.classList.toggle("hide", false);
    const workout = State.history[0];
    page.querySelector("span").innerHTML = workout.start.toLocaleTimeString();

    let listHTML = "";
    for (lift of workout.lifts) {
      const ex = State.exercises[lift.id];
      listHTML += "<li>"+ex.name+" <img width='100' src=\""+ex.img+"\"/></li>";
    }
    page.querySelector("ul.lifts-in-current-workout").innerHTML = listHTML;

  },
  "history" : () => {
    const page = document.querySelector(".page.history");
    page.classList.toggle("hide", false);

    let listHTML = "";
    for (workout of State.history) {
      listHTML += "<li>"+(workout.start.toDateString())+"</li>";
    }
    page.querySelector("ul.workouts-list").innerHTML = listHTML;

  },
};

const setup = [
  // setup start-workout page
  function() {
    const freeformBtn = document.querySelector(".page.start-workout button.start-freeform-workout");
    freeformBtn.addEventListener('click', (event) => {
      event.preventDefault();
      startNewWorkout();
      window.location.hash = "ongoing-workout";
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
  }
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
  render(window.location.hash.substr(1));
  window.addEventListener('hashchange', (event) => {
    render(window.location.hash.substr(1));
  });

  for (fn of setup) {
    fn();
  }
});

/*
function parseTemplates() {
  let templates = {};
  const container = document.getElementById("templates");
  for (child of container.children) {
    const name = child.id.substr(9);
    templates[name] = child;
  }
  return templates;
}

function updateToMatchPath(templates) {
  const path = window.location.hash.substr(1);
  if (templates[path]) {
    let raw = templates[path].innerHTML;
    // handle calls to other templates
    const matches = raw.match(/\{\{\s*([a-z\-]+)\s*\}\}/gi);
    for (match of matches) {
      const calledTemplateName = match.replace(/\{\{\s* ?/, "").replace(/\s*\}\}/, "");
      if (templates[calledTemplateName]) {
        raw = raw.replace(match, templates[calledTemplateName].innerHTML);
      }
    }
    document.getElementById("app").innerHTML = raw;
  }
}*/
