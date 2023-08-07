-----------------------------------
-- Area: Dangruf Wadi (191)
-----------------------------------
zones = zones or {}

zones[xi.zone.DANGRUF_WADI] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6543,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6549,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6550,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6552,  -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6578,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7160,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7161,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7162,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7171,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7182,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7219,  -- You can't fish here.
        DEVICE_NOT_WORKING            = 7333,  -- The device is not working.
        SYS_OVERLOAD                  = 7342,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 7347,  -- You lost the <item>.
        CRYSTALLINE_DUST              = 7351,  -- The area is littered with a white crystalline dust.
        PLANT_EXTRACT                 = 7352,  -- A plant extract is smeared around the area.
        BROKEN_EGGS                   = 7353,  -- A number of broken eggs lie scattered about.
        YOU_PLACE_ITEM                = 7354,  -- You place <item> down.
        YOU_BEAT_GOBLIN               = 7356,  -- You beat the Goblin!
        GOBLIN_BEAT_YOU               = 7357,  -- The Goblin beat you...
        YOU_GAVE_UP                   = 7358,  -- You gave up...
        BEAT_SALTVIX                  = 7363,  -- You hear a voice... (...Hmph! All happy 'cause [he/she] beat Saltvix...Won't stand chance 'gainst Grasswix of North...)
        DONT_WASTE_TIME               = 7373,  -- You hear a voice... (Grasswix don't waste time with losers...)
        BEAT_GRASSWIX                 = 7374,  -- You hear a voice... (...can't believe it! How could Grasswix lose! Eggblix of Cavern...he no lose!)
        JUST_WONT_DO                  = 7384,  -- You hear a voice... (...just won't do...nope...nope...)
        BEAT_EGGBLIX                  = 7385,  -- (...Lucky, ya are! Don't forget to say hi to our sister at Drachenfall!)
        CHEST_UNLOCKED                = 7445,  -- You unlock the chest!
        SMALL_HOLE                    = 7499,  -- There is a small hole here.
        PLAYER_OBTAINS_ITEM           = 8376,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8377,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8378,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8379,  -- You already possess that temporary item.
        NO_COMBINATION                = 8384,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10462, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11533, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
        GEYSER_OFFSET      = 17559899,
        AN_EMPTY_VESSEL_QM = 17559911,
        TREASURE_CHEST     = 17559924,
    },
}

return zones[xi.zone.DANGRUF_WADI]
