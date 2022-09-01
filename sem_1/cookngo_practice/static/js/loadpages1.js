$('a.contrlbut').on('click',null,null,function(e){
    e.preventDefault();
    var url=this.href;

    $('#container1').remove();

    $('#content').load(url+' #content').hide().fadeIn('slow');

});
