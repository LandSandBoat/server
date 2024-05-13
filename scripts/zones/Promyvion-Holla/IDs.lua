-----------------------------------
-- Area: Promyvion-Holla
-----------------------------------
zones = zones or {}

zones[xi.zone.PROMYVION_HOLLA] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        BARRIER_WOVEN                 = 7226, -- It appears to be a barrier woven from the energy of overflowing memories...
        EERIE_GREEN_GLOW              = 7228, -- The sphere is emitting an eerie green glow.
    },
    mob =
    {
        MEMORY_RECEPTACLES =
        {
            [16842781] = { 1, 3, 16843061 },
            [16842841] = { 2, 5, 16843057 },
            [16842848] = { 2, 5, 16843058 },
            [16842855] = { 2, 5, 16843059 },
            [16842862] = { 2, 5, 16843060 },
            [16842888] = { 3, 7, 16843054 },
            [16842897] = { 3, 7, 16843055 },
            [16842906] = { 3, 7, 16843056 },
            [16842940] = { 4, 7, 16843062 },
            [16842949] = { 4, 7, 16843063 },
            [16842958] = { 4, 7, 16843064 },
        },

        CEREBRATOR = GetFirstID('Cerebrator'),
    },
    npc =
    {
        MEMORY_STREAM_OFFSET = GetFirstID('_0g1'),
    },
}

return zones[xi.zone.PROMYVION_HOLLA]
