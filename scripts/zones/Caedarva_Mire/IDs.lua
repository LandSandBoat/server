-----------------------------------
-- Area: Caedarva_Mire
-----------------------------------
zones = zones or {}

zones[xi.zone.CAEDARVA_MIRE] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7061, -- You can't fish here.
        STAGING_GATE_CLOSER           = 7321, -- You must move closer.
        STAGING_GATE_INTERACT         = 7322, -- This gate guards an area under Imperial control.
        STAGING_GATE_AZOUPH           = 7323, -- Azouph Isle Staging Point.
        STAGING_GATE_DVUCCA           = 7326, -- Dvucca Isle Staging Point.
        CANNOT_LEAVE                  = 7332, -- You cannot leave this area while in the possession of <keyitem>.
        RESPONSE                      = 7341, -- There is no response...
        LOGGING_IS_POSSIBLE_HERE      = 7355, -- Logging is possible here if you have <item>.
        HAND_OVER_TO_IMMORTAL         = 7436, -- You hand over the % to the Immortal.
        YOUR_IMPERIAL_STANDING        = 7437, -- Your Imperial Standing has increased!
        CANNOT_ENTER                  = 7475, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL                     = 7476, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS                = 7480, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        MEMBER_TOO_FAR                = 7484, -- One or more party members are too far away from the entrance. Unable to enter area.
        JAZARAATS_HEADSTONE           = 7536, -- The name Sir Jazaraat is engraved on the headstone...
        SEAPRINCES_TOMBSTONE          = 8060, -- It appears to be the grave of a great soul to an age long past.
        SHED_LEAVES                   = 8066, -- The ground is strewn with shed leaves...
        SICKLY_SWEET                  = 8071, -- A sickly sweet fragrance pervades the air...
        STIFLING_STENCH               = 8077, -- A stifling stench pervades the air...
        SHREDDED_SCRAPS               = 8084, -- Shredded scraps of paper are scattered all over...
        DRAWS_NEAR                    = 8093, -- Something draws near!
        HOMEPOINT_SET                 = 8986, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 9044, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        COMMON_SENSE_SURVIVAL         = 9066, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        AYNU_KAYSEY           = GetFirstID('Aynu-kaysey'),
        CAEDARVA_TOAD         = GetFirstID('Caedarva_Toad'),
        CHIGOES =
        {
            ['Wild_Karakul'] = GetTableOfIDs('Chigoe', 5),
            ['Mosshorn']     = GetTableOfIDs('Chigoe', 5, 5),
        },
        EXPERIMENTAL_LAMIA    = GetFirstID('Experimental_Lamia'),
        JAZARAAT              = GetFirstID('Jazaraat'),
        KHIMAIRA              = GetFirstID('Khimaira'),
        LAMIA_NO27            = GetFirstID('Lamia_No27'),
        MAHJLAEF_THE_PAINTORN = GetFirstID('Mahjlaef_the_Paintorn'),
        MOSHDAHN              = GetFirstID('Moshdahn'),
        PEALLAIDH             = GetFirstID('Peallaidh'),
        PEALLAIDH_PH_OFFSET   = GetFirstID('Wild_Karakul'), -- These are 270IDs away. Use offset in case of weird shift.
        TYGER                 = GetFirstID('Tyger'),
        VERDELET              = GetFirstID('Verdelet'),
    },
    npc =
    {
        LOGGING             = GetTableOfIDs('Logging_Point'),
        RUNIC_PORTAL_AZOUPH = GetFirstID('Runic_Portal_Azouph'),
        RUNIC_PORTAL_DVUCCA = GetFirstID('Runic_Portal_Dvucca'),
    },
}

return zones[xi.zone.CAEDARVA_MIRE]
