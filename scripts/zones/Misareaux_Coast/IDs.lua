-----------------------------------
-- Area: Misareaux_Coast
-----------------------------------
zones = zones or {}

zones[xi.zone.MISAREAUX_COAST] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6408, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6423, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST             = 7029, -- You learned Trust: <name>!
        FISHING_MESSAGE_OFFSET        = 7094, -- You can't fish here.
        CONQUEST_BASE                 = 7195, -- Tallying conquest results...
        DOOR_CLOSED                   = 7371, -- The door is locked tight.
        SNOWMINT_POINT_LOCKED         = 7374, -- This gate leads to Snowmint Point. However, it seems to be locked...
        BEEP_BEEP                     = 7596, -- Beep...beep...beep...beep...
        BEEP_CLICK_WHIR               = 7597, -- Beeeep. Click, whirrr...
        BUZZ_BEEP_BEEP                = 7598, -- Buzz... Beep beep!
        FOUL_STENCH_OF_DEATH          = 7599, -- You sense the foul stench of death...
        CREATURE_HAS_APPEARED         = 7623, -- A creature has appeared out of nowhere!
        NOTHING_ELSE_OF_INTEREST      = 7624, -- There is nothing else of interest here.
        LOGGING_IS_POSSIBLE_HERE      = 7625, -- Logging is possible here if you have <item>.
        A_SHATTERED_SHIELD            = 7679, -- The ground here is littered with the pieces of a shattered shield...
        SNATCHED_AWAY                 = 7680, -- The <item> is suddenly snatched away!
        DROP_OF_OIL                   = 7682, -- A drop of oil trickles down the cheek of the mannequin.
        LARGE_DROPS_OF_OIL            = 7683, -- Large drops of oil begin pouring from the eyes on the mannequin.
        NOTHING_HERE_YET              = 7684, -- There is nothing here yet. Check again in the morning.
        ALREADY_BAITED                = 7685, -- The trap already contains <item>.
        APPEARS_TO_BE_TRAP            = 7686, -- There appears to be some kind of trap here. Bits of fish are lying around the area.
        DID_NOT_CATCH_ANYTHING        = 7687, -- You did not catch anything.
        PUT_IN_TRAP                   = 7688, -- You put <item> in the trap.
        COMMON_SENSE_SURVIVAL         = 8659, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 8723, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        HOMEPOINT_SET                 = 8882, -- Home point set!
    },
    mob =
    {
        ALSHA             = GetFirstID('Alsha'),
        BLOODY_COFFIN     = GetFirstID('Bloody_Coffin'),
        BOGGELMANN        = GetFirstID('Boggelmann'),
        FOMOR_BARD        = GetTableOfIDs('Fomor_Bard'),
        FOMOR_BLACK_MAGE  = GetTableOfIDs('Fomor_Black_Mage'),
        FOMOR_DARK_KNIGHT = GetTableOfIDs('Fomor_Dark_Knight'),
        FOMOR_DRAGOON     = GetTableOfIDs('Fomor_Dragoon'),
        FOMOR_MONK        = GetTableOfIDs('Fomor_Monk'),
        FOMOR_NINJA       = GetTableOfIDs('Fomor_Ninja'),
        FOMOR_PALADIN     = GetTableOfIDs('Fomor_Paladin'),
        FOMOR_RANGER      = GetTableOfIDs('Fomor_Ranger'),
        FOMOR_RED_MAGE    = GetTableOfIDs('Fomor_Red_Mage'),
        FOMOR_SAMURAI     = GetTableOfIDs('Fomor_Samurai'),
        FOMOR_SUMMONER    = GetTableOfIDs('Fomor_Summoner'),
        FOMOR_THIEF       = GetTableOfIDs('Fomor_Thief'),
        FOMOR_WARRIOR     = GetTableOfIDs('Fomor_Warrior'),
        GIGAS_WARWOLF     = GetTableOfIDs('Gigas_Warwolf'),
        GIGASS_SHEEP      = GetTableOfIDs('Gigass_Sheep'),
        GRATION           = GetFirstID('Gration'),
        ODQAN             = GetTableOfIDs('Odqan'),
        OKYUPETE          = GetFirstID('Okyupete'),
        PM6_2_MOB_OFFSET  = GetFirstID('Warder_Aglaia'),
        ZIPHIUS           = GetFirstID('Ziphius'),
    },
    npc =
    {
        LOGGING         = GetTableOfIDs('Logging_Point'),
        ZIPHIUS_QM_BASE = GetFirstID('qm_ziphius'),
        ALSHA_QM        = GetFirstID('qm_alsha'),
    },
}

return zones[xi.zone.MISAREAUX_COAST]
