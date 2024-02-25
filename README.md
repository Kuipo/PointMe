# PointMe
PointMe is a World of Warcraft plugin that allows you to "sync" map pins with party members automatically. If users in the same party have the plugin installed, any map pin placed will place the same pin on all other party member's maps.

# Features
- Map pins sync to party members automatically
- Map pins auto-track when placed

# Todo List
- Remove all the extra print statements
- Change "GUILD" to "PARTY"
- Fix issue with it sending an extra message back when you set a pin (currently it sends it, and then recieves it back once)
- Remove AceConsole-3.0 lib files, embed in the embeds.xml, and the PointMe:SlashProcessorFunc and PointMe:RegisterChatCommand stuff
- Put it on gitlab
- Upload it to curse or similar?
- Check if in a party in the OnMapPinChanged func to skip everything if we're not in a party at all
- Fix bug: setting map pins quickly caused it to loop and set a bunch of pins 
- Enhancement: Sync removing pins too?
- Add multiple pins and allow syncing them all (potentially color coding them to the class color?) - https://www.curseforge.com/wow/addons/mappinenhanced