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
    -- TODO: There are 3 IDs for Gyre Carlin but all the PH share the same slot.
    -- Need to verify which diremite (PH) spawns the correct ID.
    -- Since only 1 NM can be up at a time use only 1 ID until verified.
    [ID.mob.GYRE_CARLIN - 1]  = ID.mob.GYRE_CARLIN, -- Confirmed on retail
    [ID.mob.GYRE_CARLIN + 10] = ID.mob.GYRE_CARLIN, -- Confirmed on retail
    [ID.mob.GYRE_CARLIN + 23] = ID.mob.GYRE_CARLIN, -- Confirmed on retail
}

return entity
