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
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 10)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 10)
    mob:setMobMod(xi.mobMod.NO_REST, 1)
    mob:setMod(xi.mod.REGEN, 1)
end

entity.onMobSpawn = function(mob)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    mob:setMod(xi.mod.REGAIN, 100)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 54)
    mob:setMod(xi.mod.ATTP, 50)
end

entity.onMobFight = function(mob)
    -- Gains regain at under 25% HP
    local stage = mob:getLocalVar("stage")

    -- need to use this structure in case regens above back to previous stage
    if mob:getHPP() > 60 and stage ~= 0 then
        -- delay of 205
        mob:setDelay(3417)
        mob:setMod(xi.mod.REGAIN, 100)
        mob:setMobMod(xi.mobMod.SKILL_LIST, 54)
        mob:setMod(xi.mod.ATTP, 50)
        mob:setLocalVar("stage", 0)
    elseif mob:getHPP() > 25 and mob:getHPP() <= 60 and stage ~= 1 then
        -- delay of 160
        mob:setDelay(2666)
        mob:setMod(xi.mod.REGAIN, 150)
        mob:setMobMod(xi.mobMod.SKILL_LIST, 54)
        mob:setMod(xi.mod.ATTP, 50)
        mob:setLocalVar("stage", 1)
    elseif mob:getHPP() <= 25 and stage ~= 2 then
        -- delay of 100
        mob:setDelay(1666)
        mob:setMod(xi.mod.REGAIN, 200)
        -- boost by an additional 50% for 100% total boost
        mob:setMod(xi.mod.ATTP, 100)
        mob:setMobMod(xi.mobMod.SKILL_LIST, 1187)
        mob:setLocalVar("stage", 2)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        oneToBeFeared.handleOmegaDeath(mob, player, optParams)
    end
end

entity.onEventFinish = function(player, csid, option)
    oneToBeFeared.handleOmegaBattleEnding(player, csid, option)
end

return entity
