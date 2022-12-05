-----------------------------------
-- Area: Promyvion-Holla
-----------------------------------
require("scripts/globals/zone")
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
        BARRIER_WOVEN                 = 7222, -- It appears to be a barrier woven from the energy of overflowing memories...
    },
    mob =
    {
        MEMORY_RECEPTACLES =
        {
            [16842781] = { group = 1, strays = 3, stream = 16843060 },
            [16842841] = { group = 2, strays = 5, stream = 16843056 },
            [16842848] = { group = 2, strays = 5, stream = 16843057 },
            [16842855] = { group = 2, strays = 5, stream = 16843058 },
            [16842862] = { group = 2, strays = 5, stream = 16843059 },
            [16842888] = { group = 3, strays = 7, stream = 16843053 },
            [16842897] = { group = 3, strays = 7, stream = 16843054 },
            [16842906] = { group = 3, strays = 7, stream = 16843055 },
            [16842940] = { group = 4, strays = 7, stream = 16843061 },
            [16842949] = { group = 4, strays = 7, stream = 16843062 },
            [16842958] = { group = 4, strays = 7, stream = 16843063 },
        },

        CEREBRATOR    = 16843043,
    },
    npc =
    {
        MEMORY_STREAMS =
        {
            [11]        = { triggerArea = {   78, -4,   78,   82, 4,   82 }, destinations = { 46     } }, -- floor 1 return
            [21]        = { triggerArea = { -122, -4,   -2, -118, 4,    2 }, destinations = { 41     } }, -- floor 2 return
            [31]        = { triggerArea = { -162, -4,  118, -158, 4,  122 }, destinations = { 42     } }, -- floor 3 return
            [32]        = { triggerArea = {  158, -4,  238,  162, 4,  242 }, destinations = { 42     } }, -- floor 3 return
            [41]        = { triggerArea = {  118, -4, -322,  121, 4, -318 }, destinations = { 33     } }, -- floor 4 return
            [16843060]  = { triggerArea = {  -42, -4,  198,  -38, 4,  202 }, destinations = { 37     } }, -- floor 1 MR1
            [16843056]  = { triggerArea = { -240, -4,   38, -237, 4,   41 }, destinations = { 33, 34 } }, -- floor 2 MR1
            [16843057]  = { triggerArea = { -282, -4,  -42, -278, 4,  -38 }, destinations = { 33, 34 } }, -- floor 2 MR2
            [16843058]  = { triggerArea = { -162, -4, -202, -157, 4, -198 }, destinations = { 33, 34 } }, -- floor 2 MR3
            [16843059]  = { triggerArea = {   -2, -4,  -42,    2, 4,  -38 }, destinations = { 33, 34 } }, -- floor 2 MR4
            [16843053]  = { triggerArea = { -282, -4,  277, -278, 4,  282 }, destinations = { 30     } }, -- floor 3 MR1
            [16843054]  = { triggerArea = { -362, -4,  237, -358, 4,  242 }, destinations = { 30     } }, -- floor 3 MR2
            [16843055]  = { triggerArea = { -362, -4,  118, -358, 4,  122 }, destinations = { 30     } }, -- floor 3 MR3
            [16843061]  = { triggerArea = {   38, -4,  318,   42, 4,  322 }, destinations = { 30     } }, -- floor 3 MR4
            [16843062]  = { triggerArea = {  158, -4,  358,  162, 4,  362 }, destinations = { 30     } }, -- floor 3 MR5
            [16843063]  = { triggerArea = {  278, -4,  197,  282, 4,  202 }, destinations = { 30     } }, -- floor 3 MR6
        },
    },
}

return zones[xi.zone.PROMYVION_HOLLA]
