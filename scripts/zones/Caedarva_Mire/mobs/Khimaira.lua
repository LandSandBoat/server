-----------------------------------
-- Area: Caedarva Mire
--   NM: Khimaira
-----------------------------------
mixins = 
{
    require("scripts/mixins/rage"),
    require("scripts/mixins/claim_shield")
}
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    -- prevent cheesiness
    mob:setMod(xi.mod.SILENCERES, 50)
    mob:setMod(xi.mod.STUNRES, 50)
    mob:setMod(xi.mod.BINDRES, 50)
    mob:setMod(xi.mod.GRAVITYRES, 50)
    mob:setMod(xi.mod.SLEEPRES, 10000)
    mob:setMod(xi.mod.POISONRES, 100)
    mob:setMod(xi.mod.PARALYZERES, 100)
    mob:setMod(xi.mod.LULLABYRES, 10000)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 1800) -- 20 minutes
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.KHIMAIRA_CARVER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(48, 72) * 3600) -- 48 to 72 hours, in 1-hour increments
end

return entity
