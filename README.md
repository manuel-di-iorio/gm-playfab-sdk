# Microsoft Azure Playfab SDK for Game Maker Studio 2

This SDK aims to provide a wide coverage of the Microsoft Azure Playfab REST APIs, in order to add online capabilities to videogames made with Game Maker Studio 2.

The library is based on the promise/callback patterns, avoiding the need for the developer to decode the async HTTP events.

Example:

```gml
playfab_login_custom()
.next(function(resp) {
	show_debug_message("Logged in!");
})
.error(function(error) {
	show_debug_message(error)
})
```

## Playfab account

You need a Playfab account in order to use this SDK.

You can do so in few steps here: https://developer.playfab.com/en-us/sign-up

After creating the account, grab the Title ID of your game and use it to initialize the library with `playfab_init(<titleid>)`


--- 

## License

MIT
