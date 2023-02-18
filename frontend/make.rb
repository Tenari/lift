js = File.read("lift.js")
js2 = File.read("urbit-http-api.min.js")
html = File.read('index.html')
File.write(
  'build/index.html',
  html.split('<script src="file:///Users/tenari/urbit/lift/frontend/lift.js"></script>').insert(1, "<script>"+js+"</script>").join("")
    .split('<script src="file:///Users/tenari/urbit/lift/frontend/urbit-http-api.min.js"></script>').insert(1, "<script>"+js2+"</script>").join("")
)
`cp build/index.html ../desk/app/lift-ui.html`
