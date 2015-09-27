(function ($) {
  //'use strict';

  $.fn.pomodoroCounter = function(options){

    this.settings = $.extend({
    }, options );
    
    var INSTANCE_DATA_KEY = "pomodoroCounterInstance";

    var that = this;
    return this.each(function(){
      var instance = $(this).data(INSTANCE_DATA_KEY);
      
      if (!instance) {
        instance = new PomodoroCounter(this, that.settings);
      }

      $(this).data('pomodoroCounter', instance);
    });
  };

  function PomodoroCounter(element, settings) {
    this.$el = $(element);
    this.settings = settings;
    this.startMinutes = 25;
    this.startSeconds = 0;
    this.minutes = 0;
    this.seconds = 0;
    this.paused = false;
    this.intervalTime = false;
    this.projectId;
    this.taskId;

    this.start = function(minutes, seconds, project_id, task_id)
    {
      this.$el.find(".pomodoro-messages").html("");

      if (!this.intervalTime)
      {
        this.minutes = minutes;
        this.seconds = seconds;
        this.projectId = project_id;
        this.taskId = task_id;
      }

      this.clock();
    }

    this.clock = function()
    {
      var minutesElement = this.$el.find(".minutes");
      var secondsElement = this.$el.find(".seconds");
      
      this.seconds = parseInt(this.seconds) - 1;

      if (this.seconds < 0)
      {
        this.seconds = 59
        this.minutes = parseInt(this.minutes) - 1;
      }

      if (this.seconds < 10)
        this.seconds = '0' + this.seconds;

      minutesElement.html(this.minutes);
      secondsElement.html(this.seconds);
      var that = this;
      
      if ((this.minutes > 0 || this.seconds > 0) && !this.paused)
        setTimeout(function () { that.clock(); }, 1000);
      else if (this.minutes == 0 && this.seconds == 0)
        that.callback();
    }

    this.callback = function()
    {
      var audioElement = document.createElement('audio');
      audioElement.setAttribute('src', '/bell.mp3');
      audioElement.setAttribute('autoplay', 'autoplay');
      //audioElement.load()
      console.log('tocou');
      $.get();

      audioElement.addEventListener("load", function() {
          audioElement.play();
      }, true);
     
      audioElement.play();

      // Send AJAX request to server to add time in task
      var that = this;
      if (this.intervalTime)
        that.callWork();
      else
      {
        $.ajax({
          url: "/projects/" + that.projectId + "/tasks/" + that.taskId + "/add-pomodoro",
          method: "POST",
          success: function(data)
          {
            console.log('sucess');
          }
        });

        that.callInterval();
      }
    }

    this.doneTask = function(projectId, taskId)
    {
      $.ajax({
        url: "/projects/" + projectId + "/tasks/" + taskId + "/complete-json",
        method: "POST",
        success: function(data)
        {
          console.log('sucess');
        }
      });

      window.location = '/dashboard';
    }

    this.callWork = function()
    {
      this.$el.find(".pomodoro-messages").html("Hora do trabalho");
      this.intervalTime = false;
    }

    this.callInterval = function()
    {
      this.$el.find(".pomodoro-messages").html("Hora do intervalo");
      this.minutes = 0;
      this.seconds = 3;
      this.intervalTime = true;
    }

    this.pause = function()
    {
      var that = this;
      if (this.paused)
      {
        that.paused = false;
        that.clock();
      }
      else
      {
        that.paused = true;
      }
    }
  }
}( jQuery ));