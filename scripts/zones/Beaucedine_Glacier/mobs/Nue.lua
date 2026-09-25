-----------------------------------
-- Area: Beaucedine Glacier (111)
--   NM: Nue
-----------------------------------
local ID = zones[xi.zone.BEAUCEDINE_GLACIER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.NUE - 1] = ID.mob.NUE, -- Confirmed on retail
}

return entity
