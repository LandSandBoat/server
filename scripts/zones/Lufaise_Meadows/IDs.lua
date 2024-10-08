-----------------------------------
-- Area: Lufaise_Meadows
-----------------------------------
zones = zones or {}

zones[xi.zone.LUFAISE_MEADOWS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394, -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6405, -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7064, -- Tallying conquest results...
        CONQUEST                      = 7232, -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET        = 7566, -- You can't fish here.
        KI_STOLEN                     = 7695, -- The <keyitem> has been stolen!
        LOGGING_IS_POSSIBLE_HERE      = 7743, -- Logging is possible here if you have <item>.
        SURVEY_THE_SURROUNDINGS       = 7750, -- You survey the surroundings but see nothing out of the ordinary.
        MURDEROUS_PRESENCE            = 7751, -- Wait, you sense a murderous presence...!
        YOU_CAN_SEE_FOR_MALMS         = 7752, -- You can see for malms in every direction.
        SPINE_CHILLING_PRESENCE       = 7754, -- You sense a spine-chilling presence!
        KURREA_TEXT                   = 7797, -- The stench of rotten flesh fills the air around you. Some scavenger must have made this place its territory.
        COMMON_SENSE_SURVIVAL         = 8749, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 8813, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        PADFOOT               = GetTableOfIDs('Padfoot'),
        FLOCKBOCK             = GetFirstID('Flockbock'),
        MEGALOBUGARD          = GetFirstID('Megalobugard'),
        LESHY_OFFSET          = GetFirstID('Leshy'),
        COLORFUL_LESHY        = GetFirstID('Colorful_Leshy'),
        SPLINTERSPINE_GRUKJUK = GetFirstID('Splinterspine_Grukjuk'),
        KURREA                = GetFirstID('Kurrea'),
        AMALTHEIA             = GetFirstID('Amaltheia'),
        BLACKBONE_FRAZDIZ     = GetFirstID('Blackbone_Frazdiz'),
    },
    npc =
    {
        OVERSEER_BASE = GetFirstID('Jemmoquel_RK'),
        LOGGING       = GetTableOfIDs('Logging_Point'),
    },
}

return zones[xi.zone.LUFAISE_MEADOWS]
