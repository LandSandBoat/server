-----------------------------------
-- Area: Misareaux_Coast
-----------------------------------
zones = zones or {}

zones[xi.zone.MISAREAUX_COAST] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6405, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6420, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST             = 7026, -- You learned Trust: <name>!
        FISHING_MESSAGE_OFFSET        = 7090, -- You can't fish here.
        CONQUEST_BASE                 = 7190, -- Tallying conquest results...
        DOOR_CLOSED                   = 7366, -- The door is locked tight.
        SNOWMINT_POINT_LOCKED         = 7369, -- This gate leads to Snowmint Point. However, it seems to be locked...
        BEEP_BEEP                     = 7591, -- Beep...beep...beep...beep...
        BEEP_CLICK_WHIR               = 7592, -- Beeeep. Click, whirrr...
        BUZZ_BEEP_BEEP                = 7593, -- Buzz... Beep beep!
        FOUL_STENCH_OF_DEATH          = 7594, -- You sense the foul stench of death...
        CREATURE_HAS_APPEARED         = 7618, -- A creature has appeared out of nowhere!
        NOTHING_ELSE_OF_INTEREST      = 7619, -- There is nothing else of interest here.
        LOGGING_IS_POSSIBLE_HERE      = 7620, -- Logging is possible here if you have <item>.
        DROP_OF_OIL                   = 7677, -- A drop of oil trickles down the cheek of the mannequin.
        LARGE_DROPS_OF_OIL            = 7678, -- Large drops of oil begin pouring from the eyes on the mannequin.
        NOTHING_HERE_YET              = 7679, -- There is nothing here yet. Check again in the morning.
        ALREADY_BAITED                = 7680, -- The trap already contains <item>.
        APPEARS_TO_BE_TRAP            = 7681, -- There appears to be some kind of trap here. Bits of fish are lying around the area.
        DID_NOT_CATCH_ANYTHING        = 7682, -- You did not catch anything.
        PUT_IN_TRAP                   = 7683, -- You put <item> in the trap.
        COMMON_SENSE_SURVIVAL         = 8654, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 8718, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        HOMEPOINT_SET                 = 8877, -- Home point set!
    },
    mob =
    {
        ALSHA            = GetFirstID('Alsha'),
        BLOODY_COFFIN    = GetFirstID('Bloody_Coffin'),
        BOGGELMANN       = GetFirstID('Boggelmann'),
        GIGAS_WARWOLF    = GetTableOfIDs('Gigas_Warwolf'),
        GIGASS_SHEEP     = GetTableOfIDs('Gigass_Sheep'),
        GRATION          = GetFirstID('Gration'),
        OKYUPETE         = GetFirstID('Okyupete'),
        PM6_2_MOB_OFFSET = GetFirstID('Warder_Aglaia'),
        ZIPHIUS          = GetFirstID('Ziphius'),
    },
    npc =
    {
        LOGGING         = GetTableOfIDs('Logging_Point'),
        ZIPHIUS_QM_BASE = GetFirstID('qm_ziphius'),
        ALSHA_QM        = GetFirstID('qm_alsha'),
    },
}

return zones[xi.zone.MISAREAUX_COAST]
