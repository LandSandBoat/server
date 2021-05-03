-----------------------------------
-- Area: Dynamis-Bastok
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.DYNAMIS_BASTOK] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY = 6403, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 7156, -- Tallying conquest results...
        DYNAMIS_TIME_BEGIN      = 7315, -- The sands of the <item> have begun to fall. You have <number> minutes (Earth time) remaining in Dynamis.
        DYNAMIS_TIME_EXTEND     = 7316, -- our stay in Dynamis has been extended by <number> minute[/s].
        DYNAMIS_TIME_UPDATE_1   = 7317, -- ou will be expelled from Dynamis in <number> [second/minute] (Earth time).
        DYNAMIS_TIME_UPDATE_2   = 7318, -- ou will be expelled from Dynamis in <number> [seconds/minutes] (Earth time).
        DYNAMIS_TIME_EXPIRED    = 7320, -- The sands of the hourglass have emptied...
        OMINOUS_PRESENCE        = 7332, -- You feel an ominous presence, as if something might happen if you possessed <item>.
    },
    mob =
    {
        TIME_EXTENSION =
        {
            {minutes = 10, ki = xi.ki.CRIMSON_GRANULES_OF_TIME,   mob = 17539142},
            {minutes = 10, ki = xi.ki.AZURE_GRANULES_OF_TIME,     mob = 17539148},
            {minutes = 10, ki = xi.ki.AMBER_GRANULES_OF_TIME,     mob = 17539149},
            {minutes = 15, ki = xi.ki.ALABASTER_GRANULES_OF_TIME, mob = 17539253},
            {minutes = 15, ki = xi.ki.OBSIDIAN_GRANULES_OF_TIME,  mob = 17539306},
        },
        REFILL_STATUE =
        {
            {
                {mob = 17539118, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 17539119, eye = dynamis.eye.BLUE },
                {mob = 17539120, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 17539161, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 17539162, eye = dynamis.eye.BLUE },
                {mob = 17539163, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 17539171, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 17539172, eye = dynamis.eye.BLUE },
                {mob = 17539173, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 17539227, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 17539228, eye = dynamis.eye.BLUE },
                {mob = 17539229, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 17539234, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 17539235, eye = dynamis.eye.BLUE },
                {mob = 17539236, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 17539266, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 17539267, eye = dynamis.eye.BLUE },
            },
            {
                {mob = 17539274, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 17539275, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 17539286, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 17539287, eye = dynamis.eye.BLUE },
            },
            {
                {mob = 17539293, eye = dynamis.eye.RED  }, -- Adamantking_Effigy
                {mob = 17539294, eye = dynamis.eye.GREEN},
            },
        },
    },
    npc =
    {
        QM =
        {
            [17539322] =
            {
                param = {3354, 3409, 3410, 3411, 3412, 3413},
                trade =
                {
                    {item = 3354,                           mob = 17539073}, -- Gu'Dha Effigy
                    {item = {3409, 3410, 3411, 3412, 3413}, mob = 17539312}, -- Arch Gu'Dha Effigy
                }
            },
            [17539323] = {trade = {{item = 3384, mob = 17539307}}}, -- Zo'Pha Forgesoul
            [17539324] = {trade = {{item = 3385, mob = 17539308}}}, -- Ra'Gho Darkfount
            [17539325] = {trade = {{item = 3386, mob = 17539310}}}, -- Va'Zhe Pummelsong
            [17539326] = {trade = {{item = 3387, mob = 17539311}}}, -- Bu'Bho Truesteel
        },
    },
}

return zones[xi.zone.DYNAMIS_BASTOK]
