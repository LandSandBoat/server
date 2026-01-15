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
        AMALTHEIA_TEXT                = 7797, -- A message has been engraved into the rock: Offer up the ancient shield, and the pact shall be honored.
        KURREA_TEXT                   = 7801, -- The stench of rotten flesh fills the air around you. Some scavenger must have made this place its territory.
        KURREA_SLURP                  = 7804, -- Kurrea slurps down the adamantoise soup!
        KURREA_MUSCLES                = 7805, -- Kurrea's muscles bulge crazily!
        KURREA_SHINE                  = 7806, -- Kurrea's scales shine mysteriously!
        KURREA_WIND                   = 7807, -- Kurrea is enveloped by a fierce wind!
        KURREA_RIGID                  = 7808, -- Kurrea's hide grows rigid!
        KURREA_VEIN                   = 7809, -- The veins in Kurrea's head are popping out!
        KURREA_EYES                   = 7810, -- Kurrea's eyes glow weirdly!
        KURREA_CURE                   = 7811, -- Kurrea's wounds disappear!
        KURREA_AURA                   = 7812, -- Kurrea is surrounded by an ominous aura!
        KURREA_GREEN                  = 7813, -- Kurrea's face has turned green...
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
        FOMOR_BARD            = GetTableOfIDs('Fomor_Bard'),
        FOMOR_BEASTMASTER     = GetTableOfIDs('Fomor_Beastmaster'),
        FOMOR_BLACK_MAGE      = GetTableOfIDs('Fomor_Black_Mage'),
        FOMOR_DARK_KNIGHT     = GetTableOfIDs('Fomor_Dark_Knight'),
        FOMOR_DRAGOON         = GetTableOfIDs('Fomor_Dragoon'),
        FOMOR_MONK            = GetTableOfIDs('Fomor_Monk'),
        FOMOR_NINJA           = GetTableOfIDs('Fomor_Ninja'),
        FOMOR_PALADIN         = GetTableOfIDs('Fomor_Paladin'),
        FOMOR_RANGER          = GetTableOfIDs('Fomor_Ranger'),
        FOMOR_RED_MAGE        = GetTableOfIDs('Fomor_Red_Mage'),
        FOMOR_SAMURAI         = GetTableOfIDs('Fomor_Samurai'),
        FOMOR_SUMMONER        = GetTableOfIDs('Fomor_Summoner'),
        FOMOR_THIEF           = GetTableOfIDs('Fomor_Thief'),
        FOMOR_WARRIOR         = GetTableOfIDs('Fomor_Warrior'),
        KURREA                = GetFirstID('Kurrea'),
        LESHY_OFFSET          = GetFirstID('Leshy'),
        MEGALOBUGARD          = GetFirstID('Megalobugard'),
        PADFOOT               = GetTableOfIDs('Padfoot'),
        SPLINTERSPINE_GRUKJUK = GetFirstID('Splinterspine_Grukjuk'),
        TAVNAZIAN_RAM         = GetTableOfIDs('Tavnazian_Ram'),
        TAVNAZIAN_SHEEP       = GetTableOfIDs('Tavnazian_Sheep'),
    },
    npc =
    {
        LOGGING       = GetTableOfIDs('Logging_Point'),
        OVERSEER_BASE = GetFirstID('Jemmoquel_RK'),
    },
}

return zones[xi.zone.LUFAISE_MEADOWS]
