-----------------------------------
-- Area: Rolanberry Fields (110)
--  HNM: Simurgh
-----------------------------------
mixins =
{
    require("scripts/mixins/rage")
}
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.SIMURGH_POACHER)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
