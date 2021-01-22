-----------------------------------
-- Area: Mount Zhayolm
--  ZNM: Claret
-- !pos 501 -9 53
-- Spawned with Pectin: !additem 2591
-- Wiki: http://ffxiclopedia.wikia.com/wiki/Claret
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:addMod(tpz.mod.REGEN, math.floor(mob:getMaxHP()*.004))
    mob:addMod(tpz.mod.BINDRES, 40)
    mob:addMod(tpz.mod.MOVE, 15)
    mob:SetAutoAttackEnabled(false)
end

entity.onMobFight = function(mob, target)
    if mob:checkDistance(target) < 3 then
        if not target:hasStatusEffect(tpz.effect.POISON) then
            target:addStatusEffect(tpz.effect.POISON, 100, 3, math.random(3, 6) * 3) -- Poison for 3-6 ticks.
        else
            if target:getStatusEffect(tpz.effect.POISON):getPower() < 100 then
                target:delStatusEffect(tpz.effect.POISON)
                target:addStatusEffect(tpz.effect.POISON, 100, 3, math.random(3, 6) * 3) -- Poison for 3-6 ticks.
            end
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
