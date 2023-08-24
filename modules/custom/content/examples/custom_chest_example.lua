-----------------------------------
-- Custom Treasure Chest (Example)
-----------------------------------
require("modules/module_utils")
local chest = require("modules/custom/content/custom_chest")
-----------------------------------
local m = Module:new("custom_chest_example")

chest.zone[xi.zone.QUFIM_ISLAND] =
{
    name    = "Treasure Chest",          -- Target name
    look    = chest.look.TREASURE_CHEST, -- Chest model
    key     = "a Qufim Chest Key",       -- Description when clicked
    id      = 12345,                     -- eg. Qufim Chest Key (DAT mod)
    respawn = chest.respawn.MODERATE,    -- 25-30 minutes

    items =
    {
        { chest.rate.VERY_COMMON, xi.items.SEASHELL,    }, -- 24%
        { chest.rate.UNCOMMON,    xi.items.SHALL_SHELL, }, -- 10%
        { chest.rate.RARE,        xi.items.PEARL,       }, --  5%
    },

    -- Optional
    gil =
    {
        rate = chest.rate.VERY_COMMON, -- 24%
        min  = 1000,
        max  = 2000,
    },

    points =
    {
        { -249.422,  -20.000, 300.000, 120, }, -- !pos -249.422 -20.000 300.000
        { -249.422,  -20.000, 310.000, 120, }, -- !pos -249.422 -20.000 310.000
        { -249.422,  -20.000, 320.000, 120, }, -- !pos -249.422 -20.000 320.000
        { -249.422,  -20.000, 330.000, 120, }, -- !pos -249.422 -20.000 330.000
    },

    mobs =
    {
        { "Dancing_Weapon", chest.rate.RARE }, -- 5%
        { "Acrophies",      chest.rate.RARE }, -- 5%
    },
}

m:addOverride("xi.zones.Qufim_Island.Zone.onInitialize", function(zone)
    super(zone)
    chest.initZone(zone)
end)

return m
