-----------------------------------
-- Area: Dangruf Wadi (191)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.DANGRUF_WADI] =
{
    text =
    {
        CONQUEST_BASE            = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED  = 6542,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6548,  -- Obtained: <item>.
        GIL_OBTAINED             = 6549,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6551,  -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET    = 6577,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7159, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7160, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7161, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED     = 7170,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        FISHING_MESSAGE_OFFSET   = 7209,  -- You can't fish here.
        DEVICE_NOT_WORKING       = 7323,  -- The device is not working.
        SYS_OVERLOAD             = 7332,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE             = 7337,  -- You lost the <item>.
        CRYSTALLINE_DUST         = 7341,  -- The area is littered with a white crystalline dust.
        PLANT_EXTRACT            = 7342,  -- A plant extract is smeared around the area.
        BROKEN_EGGS              = 7343,  -- A number of broken eggs lie scattered about.
        YOU_PLACE_ITEM           = 7344,  -- You place <item> down.
        YOU_BEAT_GOBLIN          = 7346,  -- You beat the Goblin!
        GOBLIN_BEAT_YOU          = 7347,  -- The Goblin beat you...
        YOU_GAVE_UP              = 7348,  -- You gave up...
        BEAT_SALTVIX             = 7353,  -- You hear a voice... (...Hmph! All happy 'cause [he/she] beat Saltvix...Won't stand chance 'gainst Grasswix of North...)
        DONT_WASTE_TIME          = 7363,  -- You hear a voice... (Grasswix don't waste time with losers...)
        BEAT_GRASSWIX            = 7364,  -- You hear a voice... (...can't believe it! How could Grasswix lose! Eggblix of Cavern...he no lose!)
        JUST_WONT_DO             = 7374,  -- You hear a voice... (...just won't do...nope...nope...)
        BEAT_EGGBLIX             = 7375,  -- (...Lucky, ya are! Don't forget to say hi to our sister at Drachenfall!)
        CHEST_UNLOCKED           = 7435,  -- You unlock the chest!
        SMALL_HOLE               = 7489,  -- There is a small hole here.
        PLAYER_OBTAINS_ITEM      = 8366,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 8367,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 8368,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 8369,  -- You already possess that temporary item.
        NO_COMBINATION           = 8374,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 10452, -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 11523, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        TEPORINGO_PH  =
        {
            [17559583] = 17559584,
        },
        GEYSER_LIZARD       = 17559558,
        CHOCOBOLEECH        = 17559869,
        APPARATUS_ELEMENTAL = 17559870,
    },
    npc =
    {
        CASKET_BASE        = 17559877,
        GEYSER_OFFSET      = 17559899,
        AN_EMPTY_VESSEL_QM = 17559911,
        TREASURE_CHEST     = 17559924,
    },
}

return zones[ xi.zone.DANGRUF_WADI]
