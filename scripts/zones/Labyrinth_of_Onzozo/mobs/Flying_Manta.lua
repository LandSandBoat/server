-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Flying Manta
-- Note: PH for Lord of Onzozo and Peg Powler
-----------------------------------
local ID = zones[xi.zone.LABYRINTH_OF_ONZOZO]
-----------------------------------
local entity = {}

local lordOfOnzozoPHTable =
{
    [ID.mob.LORD_OF_ONZOZO - 1] = ID.mob.LORD_OF_ONZOZO, -- -39.356 14.265 -60.406
}

local pegPowlerPHTable =
{
    [ID.mob.PEG_POWLER - 6]  = ID.mob.PEG_POWLER, -- -100.912 4.263 -21.983
    [ID.mob.PEG_POWLER - 3]  = ID.mob.PEG_POWLER, -- -111.183 5.357 44.411
    [ID.mob.PEG_POWLER - 2]  = ID.mob.PEG_POWLER, -- -128.471 4.952 0.489
    [ID.mob.PEG_POWLER - 1]  = ID.mob.PEG_POWLER, -- -104.000 4.000 28.000
    [ID.mob.PEG_POWLER + 1]  = ID.mob.PEG_POWLER, -- -81.567 5.013 37.186
    [ID.mob.PEG_POWLER + 2]  = ID.mob.PEG_POWLER, -- -72.956 4.943 39.293
    [ID.mob.PEG_POWLER + 5]  = ID.mob.PEG_POWLER, -- -64.269 5.441 72.382
    [ID.mob.PEG_POWLER + 8]  = ID.mob.PEG_POWLER, -- -51.745 4.288 46.295
    [ID.mob.PEG_POWLER + 9]  = ID.mob.PEG_POWLER, -- -33.112 4.735 34.742
    [ID.mob.PEG_POWLER + 12] = ID.mob.PEG_POWLER, -- -65.089 5.386 81.363
    [ID.mob.PEG_POWLER + 13] = ID.mob.PEG_POWLER, -- -54.100 5.462 81.680
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 774, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, lordOfOnzozoPHTable, 4, 57600) -- 16 hour minimum
    xi.mob.phOnDespawn(mob, pegPowlerPHTable, 4, 7200) -- 2 hour minimum
end

return entity
