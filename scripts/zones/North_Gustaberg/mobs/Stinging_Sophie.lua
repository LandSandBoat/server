-----------------------------------
-- Area: North Gustaberg
--   NM: Stinging Sophie
-----------------------------------
local ID = zones[xi.zone.NORTH_GUSTABERG]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.STINGING_SOPHIE[1] - 1] = ID.mob.STINGING_SOPHIE[1], -- Confirmed on retail
    [ID.mob.STINGING_SOPHIE[2] - 1] = ID.mob.STINGING_SOPHIE[2], -- Confirmed on retail
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 197)
end

entity.onMobDespawn = function(mob)
end

return entity
