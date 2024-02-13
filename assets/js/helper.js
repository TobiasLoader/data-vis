function appendChart(id,svg,title,description,labelfuncs=[]) {
  let existing_element = d3.select("#chart-container #"+id);
  
  if (existing_element.empty()) {
    d3.select("#chart-container").append('div')
    .attr('id', id)
    .attr('class', 'chart');
  }
  
  d3.select("#"+id).append('div').attr('class', 'chart-label');
  d3.select("#"+id + " .chart-label").append("h3").text(title);
  d3.select("#"+id + " .chart-label").append("p").text(description);
  if (labelfuncs.length>0){
    d3.select("#"+id + " .chart-label").append('div').attr('class','menu-custom');
    for (let f of labelfuncs) f(d3.select("#"+id + " .menu-custom"));
  }
  
  d3.select("#"+id).append(() => svg.node());
}