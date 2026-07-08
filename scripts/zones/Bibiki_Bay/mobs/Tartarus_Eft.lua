-----------------------------------
-- Area: Bibiki Bay
--  Mob: Tartarus Eft
-- Note: PH for Splacknuck
-----------------------------------
local ID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------
---@type TMobEntity
local entity = {}
entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SPLACKNUCK, 10, 3600) -- 1 hour
end

return entity
