-----------------------------------
-- Area: Promyvion-Dem
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.PROMYVION_DEM] =
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
            [16850972] = { group = 1, strays = 3, stream = 16851277 },
            [16851026] = { group = 2, strays = 5, stream = 16851281 },
            [16851033] = { group = 2, strays = 5, stream = 16851282 },
            [16851040] = { group = 2, strays = 5, stream = 16851283 },
            [16851047] = { group = 2, strays = 5, stream = 16851284 },
            [16851073] = { group = 3, strays = 7, stream = 16851278 },
            [16851082] = { group = 3, strays = 7, stream = 16851279 },
            [16851091] = { group = 3, strays = 7, stream = 16851280 },
            [16851152] = { group = 4, strays = 7, stream = 16851285 },
            [16851161] = { group = 4, strays = 7, stream = 16851286 },
            [16851170] = { group = 4, strays = 7, stream = 16851287 },
        },

        SATIATOR = 16851267,
    },

    npc =
    {
        MEMORY_STREAMS =
        {
            [11]        = { triggerArea = {  157, -4,  -82,  161, 4,  -77 }, destinations = { 46     } }, -- floor 1 return
            [21]        = { triggerArea = { -283, -4,   -2, -278, 4,    2 }, destinations = { 41     } }, -- floor 2 return
            [31]        = { triggerArea = { -160, -4,  437, -157, 4,  441 }, destinations = { 30     } }, -- floor 3 return
            [32]        = { triggerArea = {   -2, -4, -322,    2, 4, -317 }, destinations = { 30     } }, -- floor 3 return
            [41]        = { triggerArea = {  357, -4,  237,  361, 4,  242 }, destinations = { 34     } }, -- floor 4 return
            [16851277]  = { triggerArea = {  117, -4, -283,  122, 4, -277 }, destinations = { 30     } }, -- floor 1 MR1
            [16851281]  = { triggerArea = {  -83, -4,  -83,  -77, 4,  -76 }, destinations = { 34, 35 } }, -- floor 2 MR1
            [16851282]  = { triggerArea = {  -82, -4,   76,  -77, 4,   80 }, destinations = { 34, 35 } }, -- floor 2 MR2
            [16851283]  = { triggerArea = { -282, -4, -202, -277, 4, -196 }, destinations = { 34, 35 } }, -- floor 2 MR3
            [16851284]  = { triggerArea = { -361, -4,   36, -356, 4,   42 }, destinations = { 34, 35 } }, -- floor 2 MR4
            [16851278]  = { triggerArea = {   37, -4, -203,   43, 4, -198 }, destinations = { 32     } }, -- floor 3 MR1
            [16851279]  = { triggerArea = { -122, -4, -242, -116, 4, -237 }, destinations = { 32     } }, -- floor 3 MR2
            [16851280]  = { triggerArea = { -122, -4, -402, -116, 4, -396 }, destinations = { 32     } }, -- floor 3 MR3
            [16851285]  = { triggerArea = { -322, -4,  156, -316, 4,  162 }, destinations = { 32     } }, -- floor 3 MR4
            [16851286]  = { triggerArea = {  -42, -4,  317,  -37, 4,  322 }, destinations = { 32     } }, -- floor 3 MR5
            [16851287]  = { triggerArea = { -122, -4,  157, -118, 4,  163 }, destinations = { 32     } }, -- floor 3 MR6
        },
    },
}

return zones[xi.zone.PROMYVION_DEM]
