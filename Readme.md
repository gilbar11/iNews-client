# Event Shooter

Ruby client for iNEWS Web Services API

The implementation here is mostly for watching a queue of stories, and checking
what the story status is. 

This service works as a daemon that watches an iNEWS rundown while the show is
on air. You can get information about a story, and if it got fired already. 

You can implement more actions of the iNEWS WSAPI easily with this client.
http://www.avid.com/static/resources/common/documents/iNEWS_Whitepaper.pdf


## How To Install

  ```
  $ git clone https://github.com/gilbar11/iNewsClient.git
  ```
  ```
  $ cd iNewsClient
  ```
  ```
  $ bundle install
  ```


## Use cases

  The service was developed under the assumption that for every rundown (TV
  Show) there is a dedicated instance, which will be terminated at the end of
  the show. 

####  Launch 

  ```      
  $ bin/watcher "settings.yml"
  ``` 
