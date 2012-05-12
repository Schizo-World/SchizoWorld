var labelType, useGradients, nativeTextSupport, animate;

(function() {
  
  $.ajax({ 
        url  : "/js/libs/tree_data.json",
         dataType: 'json',
        success: function(data) {
          //success
          init(data);
        }, 
        error: function (xhr, ajaxOptions, thrownError){
          //didn't work!'
        } 
  });

  var ua = navigator.userAgent,
      iStuff = ua.match(/iPhone/i) || ua.match(/iPad/i),
      typeOfCanvas = typeof HTMLCanvasElement,
      nativeCanvasSupport = (typeOfCanvas == 'object' || typeOfCanvas == 'function'),
      textSupport = nativeCanvasSupport 
        && (typeof document.createElement('canvas').getContext('2d').fillText == 'function');
  //I'm setting this based on the fact that ExCanvas provides text support for IE
  //and that as of today iPhone/iPad current text support is lame
  labelType = (!nativeCanvasSupport || (textSupport && !iStuff))? 'Native' : 'HTML';
  nativeTextSupport = labelType == 'Native';
  useGradients = nativeCanvasSupport;
  animate = !(iStuff || !nativeCanvasSupport);
})();

var Log = {
  elem: false,
  write: function(text){
    if (!this.elem) 
      this.elem = document.getElementById('log');
    this.elem.innerHTML = text;
    this.elem.style.left = (500 - this.elem.offsetWidth / 2) + 'px';
  }
};

function init(data){

    //init data
    var jsonString = JSON.stringify(data); //convert the json object in a String
    jsonString = jsonString.slice(1); //remove first sq Barcket[
    jsonString = jsonString.slice(0,-1); //remove last sq Barcket]
    var json = JSON.parse(jsonString); //Parse my json from the jsonString
    
    //end
    //init Spacetree
    //Create a new ST instance
    var st = new $jit.ST({
        //id of viz container element
        injectInto: 'infovis',
        //set duration for the animation
        duration: 600,
        //set animation transition type
        transition: $jit.Trans.Quart.easeInOut,
        //set distance between node and its children
        levelDistance: 50,
        //set orientation
        orientation: 'bottom',
		//set the levels to show each time
		levelsToShow:1,
        //enable panning
        Navigation: {
          enable:true,
          panning:false
        },
        //set node and edge styles
        //set overridable=true for styling individual
        //nodes or edges
        Node: {
            height: 45,
            width: 70,
            type: 'none',
            color: '#aaa',
            overridable: true
        },
        
        Edge: {
            type: 'bezier',
            lineWidth:2,
            overridable: true
        },
        
        onBeforeCompute: function(node){
            Log.write("loading ... "/* + node.name*/);
        },
        
        onAfterCompute: function(){
            Log.write("done");
        },
        
        //This method is called on DOM label creation.
        //Use this method to add event handlers and styles to
        //your node.
        onCreateLabel: function(label, node){
            label.id = node.id;  
            label.title = node.title;
            alert(node.id);
            alert(node.img);   
            alert(node.title);       
            label.innerHTML = "<div id='tree_node' />" + "<div id='tree_image'>" + "<img src='/img/eastwood.png' height='45px'/>" + "</div></div>";
            label.onclick = function(){
              st.onClick(node.id);	
            };
            
            //set label styles
            var style = label.style;
            style.width = 70 + 'px';
            style.height = 45 + 'px';            
            style.cursor = 'pointer';
            style.color = '#000';
            style.fontSize = '0.8em';
            style.textAlign= 'center';
        },
        
        //This method is called right before plotting
        //a node. It's useful for changing an individual node
        //style properties before plotting it.
        //The data properties prefixed with a dollar
        //sign will override the global node style properties.
        onBeforePlotNode: function(node){
            //add some color to the nodes in the path between the
            //root node and the selected node.
            if (node.selected) {
                node.data.$color = "#ff0000";
            }
            else {
                delete node.data.$color;
                //if the node belongs to the last plotted level
                if(!node.anySubnode("exist")) {
                    //count children number
                    var count = 0;
                    node.eachSubnode(function(n) {count++;});
                    //assign a node color based on
                    //how many children it has
                    node.data.$color = ['#aaa', '#baa', '#caa', '#daa', '#eaa', '#faa'][count];                    
                }
            }
        },
        
        //This method is called right before plotting
        //an edge. It's useful for changing an individual edge
        //style properties before plotting it.
        //Edge data proprties prefixed with a dollar sign will
        //override the Edge global style properties.
        onBeforePlotLine: function(adj){
            if (adj.nodeFrom.selected && adj.nodeTo.selected) {
                adj.data.$color = "#E6010F";
                adj.data.$lineWidth = 3;
            }
            else {
                delete adj.data.$color;
                delete adj.data.$lineWidth;
            }
        }
    });
    //load json data
    st.loadJSON(json);
    //compute node positions and layout
    st.compute();
    //optional: make a translation of the tree
    st.geom.translate(new $jit.Complex(0, 300), "current");
    //emulate a click on the root node.
    //st.onClick(st.root); //'node4106'
	var node_displayed = st.root;
	st.onClick(node_displayed);
    //end
}
