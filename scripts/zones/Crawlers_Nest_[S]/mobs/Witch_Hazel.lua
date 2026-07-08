-----------------------------------
-- Area: Crawlers' Nest [S]
--  Mob: Witch Hazel
-- Note: PH for Morille Mortelle
-----------------------------------
local ID = zones[xi.zone.CRAWLERS_NEST_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.MORILLE_MORTELLE, 12, 18000) -- 5 hours
end

return entity
