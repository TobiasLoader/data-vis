// Declare the chart dimensions and margins.
const width = 640;
const height = 400;
const marginTop = 20;
const marginRight = 20;
const marginBottom = 30;
const marginLeft = 40;

// Declare the x (horizontal position) scale.
const x = d3.scaleUtc()
    .domain([new Date("2023-01-01"), new Date("2024-01-01")])
    .range([marginLeft, width - marginRight]);

// Declare the y (vertical position) scale.
const y = d3.scaleLinear()
    .domain([0, 100])
    .range([height - marginBottom, marginTop]);

// Create the SVG container.
const svg = d3.create("svg")
    .attr("width", width)
    .attr("height", height);

// Add the x-axis.
svg.append("g")
    .attr("transform", `translate(0,${height - marginBottom})`)
    .call(d3.axisBottom(x));

// Add the y-axis.
svg.append("g")
    .attr("transform", `translate(${marginLeft},0)`)
    .call(d3.axisLeft(y));

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
   { x: new Date("2023-10-15"), y: 30 },
   { x: new Date("2023-11-15"), y: 45 },
   { x: new Date("2023-12-15"), y: 50 },
];
svg.selectAll("circle")
   .data(dataPoints)
   .join("circle")
   .attr("cx", d => x(d.x))
   .attr("cy", d => y(d.y))
   .attr("r", 5)
   .attr("fill", "rgb(45, 166, 128)");  // same as --pri-col in CSS

// Append the SVG element.
d3.select("#chart-container").append(() => svg.node());
