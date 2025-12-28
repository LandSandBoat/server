-----------------------------------
-- Area: Palborough Mines
--  Mob: Copper Quadav
-- Note: PH for Be'Hya Hundredwall
-----------------------------------
local ID = zones[xi.zone.PALBOROUGH_MINES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BEHYA_HUNDREDWALL, 10, 3600) -- 1 hour
end

return entity
