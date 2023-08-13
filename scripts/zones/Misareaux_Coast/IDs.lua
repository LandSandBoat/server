-----------------------------------
-- Area: Misareaux_Coast
-----------------------------------
zones = zones or {}

zones[xi.zone.MISAREAUX_COAST] =
{
    text =
    {
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
        YOU_LEARNED_TRUST             = 7025, -- You learned Trust: <name>!
        FISHING_MESSAGE_OFFSET        = 7082, -- You can't fish here.
        CONQUEST_BASE                 = 7182, -- Tallying conquest results...
        DOOR_CLOSED                   = 7358, -- The door is locked tight.
        SNOWMINT_POINT_LOCKED         = 7361, -- This gate leads to Snowmint Point. However, it seems to be locked...
        BEEP_BEEP                     = 7583, -- Beep...beep...beep...beep...
        BEEP_CLICK_WHIR               = 7584, -- Beeeep. Click, whirrr...
        BUZZ_BEEP_BEEP                = 7585, -- Buzz... Beep beep!
        CREATURE_HAS_APPEARED         = 7610, -- A creature has appeared out of nowhere!
        NOTHING_ELSE_OF_INTEREST      = 7611, -- There is nothing else of interest here.
        LOGGING_IS_POSSIBLE_HERE      = 7612, -- Logging is possible here if you have <item>.
        DROP_OF_OIL                   = 7669, -- A drop of oil trickles down the cheek of the mannequin.
        LARGE_DROPS_OF_OIL            = 7670, -- Large drops of oil begin pouring from the eyes on the mannequin.
        NOTHING_HERE_YET              = 7671, -- There is nothing here yet. Check again in the morning.
        ALREADY_BAITED                = 7672, -- The trap already contains <item>.
        APPEARS_TO_BE_TRAP            = 7673, -- There appears to be some kind of trap here. Bits of fish are lying around the area.
        DID_NOT_CATCH_ANYTHING        = 7674, -- You did not catch anything.
        PUT_IN_TRAP                   = 7675, -- You put <item> in the trap.
        COMMON_SENSE_SURVIVAL         = 8646, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 8710, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        HOMEPOINT_SET                 = 8869, -- Home point set!
    },
    mob =
    {
        OKYUPETE_PH =
        {
            [16879839] = 16879847,
        },
        PM6_2_MOB_OFFSET = 16879893,
        BOGGELMANN       = 16879897,
        GRATION          = 16879899,
        ZIPHIUS          = 16879900,
        ALSHA            = 16879898,
    },
    npc =
    {
        LOGGING         = GetTableOfIDs('Logging_Point'),
        ZIPHIUS_QM_BASE = 16879919,
        ALSHA_QM        = 16879978,
    },
}

return zones[xi.zone.MISAREAUX_COAST]
