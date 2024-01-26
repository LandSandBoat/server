-----------------------------------
-- Area: Riverne - Site B01
--   NM: Unstable Cluster
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.BLAZE_SPIKES, 35, 0, 0)
    mob:getStatusEffect(xi.effect.BLAZE_SPIKES):setFlag(xi.effectFlag.DEATH)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:addMod(xi.mod.SLEEPRES, 90)
end

entity.onMobFight = function(mob)
    if
        (mob:getAnimationSub() == 4 or
        mob:getAnimationSub() == 0) and
        mob:getMod(xi.mod.TRIPLE_ATTACK) == 0
    then
        mob:setMod(xi.mod.TRIPLE_ATTACK, 100)
    elseif
        (mob:getAnimationSub() == 5 or
        mob:getAnimationSub() == 1) and
        mob:getMod(xi.mod.TRIPLE_ATTACK) > 0
    then
        mob:setMod(xi.mod.TRIPLE_ATTACK, 0)
        mob:setMod(xi.mod.DOUBLE_ATTACK, 100)
    elseif
        (mob:getAnimationSub() == 6 or
        mob:getAnimationSub() == 2) and
        mob:getMod(xi.mod.DOUBLE_ATTACK) > 0
    then
        mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 0)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
end

return entity
