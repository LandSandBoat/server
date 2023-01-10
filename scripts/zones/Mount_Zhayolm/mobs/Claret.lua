-----------------------------------
-- Area: Mount Zhayolm
--  ZNM: Claret
-- !pos 501 -9 53
-- Spawned with Pectin: !additem 2591
-- Wiki: http://ffxiclopedia.wikia.com/wiki/Claret
-----------------------------------
mixins = { require("scripts/mixins/rage") }
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:addMod(xi.mod.REGEN, math.floor(mob:getMaxHP() * 0.004))
    mob:addMod(xi.mod.BIND_MEVA, 40)
    mob:addMod(xi.mod.MOVE, 15)
    mob:setAutoAttackEnabled(false)
end

entity.onMobFight = function(mob, target)
    if mob:checkDistance(target) < 3 then
        if not target:hasStatusEffect(xi.effect.POISON) then
            target:addStatusEffect(xi.effect.POISON, 100, 3, math.random(3, 6) * 3) -- Poison for 3-6 ticks.
        else
            if target:getStatusEffect(xi.effect.POISON):getPower() < 100 then
                target:delStatusEffect(xi.effect.POISON)
                target:addStatusEffect(xi.effect.POISON, 100, 3, math.random(3, 6) * 3) -- Poison for 3-6 ticks.
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
