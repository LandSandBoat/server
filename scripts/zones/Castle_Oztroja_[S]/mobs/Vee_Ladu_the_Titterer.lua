-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Vee Ladu the Titterer
-- TODO: summons up to four low-HP copies of itself when it casts utsusemi: ni
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(7200, 14400)) -- 2 to 4 hours
end

return entity
