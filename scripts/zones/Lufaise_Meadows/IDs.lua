-----------------------------------
-- Area: Lufaise_Meadows
-----------------------------------
zones = zones or {}

zones[xi.zone.LUFAISE_MEADOWS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6395, -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6405, -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6406, -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6420, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7068, -- Tallying conquest results...
        CONQUEST                      = 7236, -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET        = 7570, -- You can't fish here.
        KI_STOLEN                     = 7699, -- The <keyitem> has been stolen!
        LOGGING_IS_POSSIBLE_HERE      = 7747, -- Logging is possible here if you have <item>.
        SURVEY_THE_SURROUNDINGS       = 7754, -- You survey the surroundings but see nothing out of the ordinary.
        MURDEROUS_PRESENCE            = 7755, -- Wait, you sense a murderous presence...!
        YOU_CAN_SEE_FOR_MALMS         = 7756, -- You can see for malms in every direction.
        SPINE_CHILLING_PRESENCE       = 7758, -- You sense a spine-chilling presence!
        KURREA_TEXT                   = 7801, -- The stench of rotten flesh fills the air around you. Some scavenger must have made this place its territory.
        COMMON_SENSE_SURVIVAL         = 8753, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 8817, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        AMALTHEIA             = GetFirstID('Amaltheia'),
        BAUMESEL              = GetFirstID('Baumesel'),
        BLACKBONE_FRAZDIZ     = GetFirstID('Blackbone_Frazdiz'),
        COLORFUL_LESHY        = GetFirstID('Colorful_Leshy'),
        FLOCKBOCK             = GetFirstID('Flockbock'),
        KURREA                = GetFirstID('Kurrea'),
        LESHY_OFFSET          = GetFirstID('Leshy'),
        MEGALOBUGARD          = GetFirstID('Megalobugard'),
        PADFOOT               = GetTableOfIDs('Padfoot'),
        SPLINTERSPINE_GRUKJUK = GetFirstID('Splinterspine_Grukjuk'),
    },
    npc =
    {
        LOGGING       = GetTableOfIDs('Logging_Point'),
        OVERSEER_BASE = GetFirstID('Jemmoquel_RK'),
    },
}

return zones[xi.zone.LUFAISE_MEADOWS]
