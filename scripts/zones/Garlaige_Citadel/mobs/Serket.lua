-----------------------------------
-- Area: Garlaige Citadel (200)
--   NM: Serket
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 20000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 20000)
    mob:addImmunity(xi.immunity.POISON)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 1800) -- 30 minutes
end

entity.onMobFight = function(mob, target)
    local drawInTable =
    {
        conditions =
        {
            mob:checkDistance(target) > mob:getMeleeRange(),
        },
        position = mob:getPos(),
        wait = 3,
    }
    utils.drawIn(target, drawInTable)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.SERKET_BREAKER)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
