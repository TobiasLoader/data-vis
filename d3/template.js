// Declare the chart dimensions and margins.
const width = 640;
const height = 400;
const marginTop = 20;
const marginRight = 20;
const marginBottom = 30;
const marginLeft = 40;

// Declare the x (horizontal position) scale.
const x1 = d3.scaleUtc()
    .domain([new Date("2023-01-01"), new Date("2024-01-01")])
    .range([marginLeft, width - marginRight]);

// Declare the y (vertical position) scale.
const y1 = d3.scaleLinear()
    .domain([0, 100])
    .range([height - marginBottom, marginTop]);

// Declare the x (horizontal position) scale.
const x2 = d3.scaleLinear()
    .domain([0, 100])
    .range([marginLeft, width - marginRight]);

// Declare the y (vertical position) scale.
const y2 = d3.scaleUtc()
    .domain([new Date("2023-01-01"), new Date("2024-01-01")])
    .range([height - marginBottom, marginTop]);

const svg1 = d3.create("svg")
    .attr("width", width)
    .attr("height", height);
    
const svg2 = d3.create("svg")
    .attr("width", width)
    .attr("height", height);

// Add the x-axis.
svg1.append("g")
    .attr("transform", `translate(0,${height - marginBottom})`)
    .call(d3.axisBottom(x1));

// Add the y-axis.
svg1.append("g")
    .attr("transform", `translate(${marginLeft},0)`)
    .call(d3.axisLeft(y1));

// Add the x-axis.
svg2.append("g")
    .attr("transform", `translate(0,${height - marginBottom})`)
    .call(d3.axisBottom(x2));

// Add the y-axis.
svg2.append("g")
    .attr("transform", `translate(${marginLeft},0)`)
    .call(d3.axisLeft(y2));


// Add a data point
const dataPoints = [
   { x: new Date("2023-01-15"), y: 20 },
   { x: new Date("2023-02-15"), y: 30 },
   { x: new Date("2023-03-15"), y: 25 },
   { x: new Date("2023-04-15"), y: 30 },
   { x: new Date("2023-05-15"), y: 35 },
   { x: new Date("2023-06-15"), y: 30 },
   { x: new Date("2023-07-15"), y: 25 },
   { x: new Date("2023-08-15"), y: 40 },
   { x: new Date("2023-09-15"), y: 35 },
   { x: new Date("2023-10-15"), y: 35 },
   { x: new Date("2023-11-15"), y: 45 },
   { x: new Date("2023-12-15"), y: 50 },
];

svg1.selectAll("circle")
   .data(dataPoints)
   .join("circle")
   .attr("cx", d => x1(d.x))
   .attr("cy", d => y1(d.y))
   .attr("r", 5)
   .attr("fill", "rgb(45, 166, 128)");  // same as --pri-col in CSS

svg2.selectAll("circle")
    .data(dataPoints)
    .join("circle")
    .attr("cx", d => x2(d.y))
    .attr("cy", d => y2(d.x))
    .attr("r", 5)
    .attr("fill", "rgb(45, 166, 128)");  // same as --pri-col in CSS

// Append the SVG element.
d3.select("#chart-container").append('div')
   .attr('id', 'svg-container1')
   .attr('class', 'chart');
d3.select("#svg-container1").append('div').attr('class', 'chart-label');
d3.select("#svg-container1 .chart-label").append("h3").text("Chart title");
d3.select("#svg-container1 .chart-label").append("p").text("Chart description");
d3.select("#svg-container1").append(() => svg1.node());

d3.select("#chart-container").append('div').attr('class', 'separator');

d3.select("#chart-container").append('div')
   .attr('id', 'svg-container2')
   .attr('class', 'chart');
d3.select("#svg-container2").append('div').attr('class', 'chart-label');
d3.select("#svg-container2 .chart-label").append("h3").text("Chart title");
d3.select("#svg-container2 .chart-label").append("p").text("Chart description");
d3.select("#svg-container2").append(() => svg2.node());