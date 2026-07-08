-----------------------------------
-- Area: Bibiki Bay
--  Mob: Eft
-- Note: PH for Intulo
-----------------------------------
local ID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------
---@type TMobEntity
local entity = {}
entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.INTULO, 10, 3600) -- 1 hour
end

return entity
