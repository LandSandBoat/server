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
    [ID.mob.NUE - 2] = ID.mob.NUE, -- -342.830 -100.584 168.662
    [ID.mob.NUE - 1] = ID.mob.NUE, -- -322.000 -100.000 116.000
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
