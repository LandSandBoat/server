-----------------------------------
-- Area: Pso'Xja
--  Mob: Gyre-Carlin
-----------------------------------
local ID = zones[xi.zone.PSOXJA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.GYRE_CARLIN - 1] = ID.mob.GYRE_CARLIN, -- Confirmed on retail
}

return entity
