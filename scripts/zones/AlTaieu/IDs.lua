-----------------------------------
-- Area: AlTaieu
-----------------------------------
zones = zones or {}

zones[xi.zone.ALTAIEU] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7164, -- Tallying conquest results...
        QUASILUMIN_01                 = 7380, -- This is Al'Taieu. The celestial capital overflowing with the blessings of Altana.
        IMPERVIOUS_FIELD_BLOCKS       = 7461, -- An impervious field of energy blocks your path...
        NOTHING_OF_INTEREST           = 7490, -- There is nothing of interest here.
        OMINOUS_SHADOW                = 7491, -- An ominous shadow falls over you...
        AMULET_SHATTERED              = 7512, -- The <item> held by <name> has shattered...
        LIGHT_STOLEN                  = 7513, -- The <item> was stolen by Nag'molada...
        OBTAIN_BUT_STOLEN             = 7514, -- You obtain the <item>, only to have it stolen by Nag'molada...
        RETURN_AMULET_TO_PRISHE       = 7538, -- You return the <item> to Prishe.
        HOMEPOINT_SET                 = 7579, -- Home point set!
    },
    mob =
    {
        EUVHIS_OFFSET      = GetFirstID('Aweuvhi'),
        ULXZOMIT_OFFSET    = GetTableOfIDs('Ulxzomit'),
        OMXZOMIT_OFFSET    = GetTableOfIDs('Omxzomit'),
        RUAERN             = GetFirstID('Ruaern'),
        JAILER_OF_HOPE     = GetFirstID('Jailer_of_Hope'),
        JAILER_OF_JUSTICE  = GetFirstID('Jailer_of_Justice'),
        JAILER_OF_PRUDENCE = GetFirstID('Jailer_of_Prudence'),
        JAILER_OF_LOVE     = GetFirstID('Jailer_of_Love'),
        ABSOLUTE_VIRTUE    = GetFirstID('Absolute_Virtue'),
    },
    npc =
    {
        RUBIOUS_CRYSTAL           = GetFirstID('_0x1'),
        AURORAL_UPDRAFT_OFFSET    = GetFirstID('Auroral_Updraft'),
        SWIRLING_VORTEX_OFFSET    = GetFirstID('Swirling_Vortex'),
        DIMENSIONAL_PORTAL_OFFSET = GetFirstID('Dimensional_Portal'),
    },
}

return zones[xi.zone.ALTAIEU]
