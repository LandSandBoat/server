-----------------------------------
-- Area: Sealions Den
--  Mob: Omega
-----------------------------------
local oneToBeFeared = require("scripts/zones/Sealions_Den/bcnms/one_to_be_feared_helper")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
end

entity.onMobSpawn = function(mob)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
end

entity.onMobFight = function(mob)
    -- Gains regain at under 25% HP
    if
        mob:getHPP() < 25 and not
        mob:hasStatusEffect(xi.effect.REGAIN)
    then
        mob:addStatusEffect(xi.effect.REGAIN, 5, 3, 0)
        mob:getStatusEffect(xi.effect.REGAIN):setFlag(xi.effectFlag.DEATH)
    -- Changes AA round delay as it gets weaker
    elseif mob:getHPP() < 60 then
        mob:setDelay(3000)
    elseif mob:getHPP() < 25 then
        mob:setDelay(2500)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN)
end

entity.onMobDeath = function(mob, player, isKiller)
    oneToBeFeared.handleOmegaDeath(mob, player, isKiller)
end

entity.onEventFinish = function(player, csid, option)
    oneToBeFeared.handleOmegaBattleEnding(player, csid, option)
end

return entity
