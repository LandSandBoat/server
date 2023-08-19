-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Koropokkur
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 361)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(3600, 5400)) -- 60-90min repop
end

return entity
