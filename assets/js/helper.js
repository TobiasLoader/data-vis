function appendChart(id,svg,title,description) {
  d3.select("#chart-container").append('div')
    .attr('id', id)
    .attr('class', 'chart');
  d3.select("#"+id).append('div').attr('class', 'chart-label');
  d3.select("#"+id + " .chart-label").append("h3").text(title);
  d3.select("#"+id + " .chart-label").append("p").text(description);
  d3.select("#"+id).append(() => svg.node());
}