-----------------------------------
-- Area: Bibiki Bay
--  Mob: Eft
-- Note: PH for Intulo
-----------------------------------
local ID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------
---@type TMobEntity
local entity = {}
entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.INTULO, 10, 3600) -- 1 hour
end

return entity
