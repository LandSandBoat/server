-----------------------------------
-- Area: Zhayolm_Remnants
-----------------------------------
zones = zones or {}

zones[xi.zone.ZHAYOLM_REMNANTS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6388, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394, -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                = 6399, -- You obtain <number> <item>!
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CELL_OFFSET                   = 7224, -- Main Weapon/Sub-Weapon restriction removed.
        TEMP_ITEM                     = 7245, -- Obtained temporary item: <item>.
        HAVE_TEMP_ITEM                = 7246, -- You already have that temporary item.
        SALVAGE_START                 = 7247, -- You feel an incredible pressure bearing down on you. This area appears to be blanketed in some sort of intense psionic field...
        TIME_TO_COMPLETE              = 7419, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7420, -- The mission has failed. Leaving area.
        TIME_REMAINING_MINUTES        = 7424, -- Time remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7425, -- Time remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN                  = 7427, -- all party members have fallen in battle. Mission failure in <number> [minute/minutes].
        DOOR_IS_SEALED                = 7438, -- The door is sealed...
        NOT_RESPONDING                = 7440, -- The Device doesn't respond
        DOOR_IS_SEALED_MYSTERIOUS     = 7445, -- The door is sealed by some mysterious force...
        SOCKET_TRIGGER                = 7446, -- You hear a ragged sighing from beneath the floor...
        SLOT_TRIGGER                  = 7447, -- You hear a scuttering sound from beneth...
    },
    mob =
    {
        ARCHAIC_CHARIOT    = GetTableOfIDs('Archaic_Chariot'),
        ARCHAIC_GEAR       = GetTableOfIDs('Archaic_Gear'),
        ARCHAIC_GEARS      = GetTableOfIDs('Archaic_Gears'),
        ARCHAIC_RAMPART    = GetTableOfIDs('Archaic_Rampart'),
        BATTLECLAD_CHARIOT = GetFirstID('Battleclad_Chariot'),
        BULL_BUGARD        = GetTableOfIDs('Bull_Bugard'),
        DRACO_LIZARD       = GetTableOfIDs('Draco_Lizard'),
        FIRST_RAMPART      = GetTableOfIDs('First_Rampart'),
        FOURTH_RAMPART     = GetTableOfIDs('Fourth_Rampart'),
        JAKKO              = GetFirstID('Jakko'),
        MAMOOL_JA_BOUNDER  = GetTableOfIDs('Mamool_Ja_Bounder'),
        MAMOOL_JA_MIMICKER = GetTableOfIDs('Mamool_Ja_Mimicker'),
        MAMOOL_JA_SAVANT   = GetTableOfIDs('Mamool_Ja_Savant'),
        MAMOOL_JA_SOPHIST  = GetTableOfIDs('Mamool_Ja_Sophist'),
        MAMOOL_JA_SPEARMAN = GetTableOfIDs('Mamool_Ja_Spearman'),
        MAMOOL_JA_STRAPER  = GetTableOfIDs('Mamool_Ja_Strapper'),
        MAMOOL_JA_ZENIST   = GetTableOfIDs('Mamool_Ja_Zenist'),
        POROGGO_GENT       = GetTableOfIDs('Poroggo_Gent'),
        POROGGO_MADAME     = GetTableOfIDs('Poroggo_Madame'),
        PUK                = GetTableOfIDs('Puk'),
        SECOND_RAMPART     = GetTableOfIDs('Second_Rampart'),
        THIRD_RAMPART      = GetTableOfIDs('Third_Rampart'),
        VAGRANT_LINDWURM   = GetTableOfIDs('Vagrant_Lindwurm'),
        WYVERN             = GetTableOfIDs('Wyvern'),
        ZIZ                = GetTableOfIDs('Ziz'),
    },
    npc =
    {
        ARMOURY_CRATE = GetTableOfIDs('Armoury_Crate'),
        SLOT          = GetFirstID('Slot'),
        SOCKET        = GetFirstID('Socket'),
        DOOR_1_0      = GetFirstID('_210'),
        DOOR_1_1      = GetFirstID('_211'),
        DOOR_1_2      = GetFirstID('_212'),
        DOOR_1_3      = GetFirstID('_213'),
        DOOR_1_4      = GetFirstID('_214'),
        DOOR_2_1      = GetFirstID('_215'),
        DOOR_2_2      = GetFirstID('_216'),
        DOOR_2_3      = GetFirstID('_217'),
        DOOR_2_4      = GetFirstID('_218'),
        DOOR_3_1      = GetFirstID('_219'),
        DOOR_3_2      = GetFirstID('_21a'),
        DOOR_4_1      = GetFirstID('_21b'),
        DOOR_4_2      = GetFirstID('_21c'),
        DOOR_5_1      = GetFirstID('_21d'),
        DOOR_5_2      = GetFirstID('_21e'),
        DOOR_6_1      = GetFirstID('_21f'),
        DOOR_7_1      = GetFirstID('_21g'),
    },
}

return zones[xi.zone.ZHAYOLM_REMNANTS]
