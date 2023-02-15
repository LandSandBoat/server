-----------------------------------
-- Area: Mount Zhayolm
--   NM: Cerberus
-----------------------------------
mixins = 
{
    require("scripts/mixins/rage"),
    require("scripts/mixins/claim_shield")
}
require("scripts/globals/status")
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

entity.onMobFight = function(mob, target)
    if mob:getHPP() > 25 then
        mob:setMod(xi.mod.REGAIN, 10)
    else
        mob:setMod(xi.mod.REGAIN, 70)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.CERBERUS_MUZZLER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(48, 72) * 3600) -- 48 - 72 hours with 1 hour windows
end

return entity
