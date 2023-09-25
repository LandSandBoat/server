-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Seiryu
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SILENCERES, 90)
    mob:addMod(xi.mod.ATT, 50)
    mob:addMod(xi.mod.EVA, 80)
    mob:addMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
    -- TP move about every 9 seconds without TP feed
    mob:setMod(xi.mod.REGAIN, 750)
end

entity.onMobSpawn = function(mob, target)
    GetNPCByID(ID.npc.PORTAL_TO_SEIRYU):setAnimation(xi.anim.CLOSE_DOOR)
    mob:setMagicCastingEnabled(false)
end

entity.onMobEngaged = function(mob, target)
    mob:messageText(mob, ID.text.SKY_GOD_OFFSET + 9)
    mob:timer(5000, function(mobArg)
        mobArg:setMagicCastingEnabled(true)
    end)
end

entity.onMobFight = function(mob, target)
    -- adjust when below 50% and 25% as Seiryu has the same TP move rate
    if mob:getHPP() <= 25 and mob:getMod(xi.mod.REGAIN) ~= 250 then
        mob:setMod(xi.mod.REGAIN, 250)
    elseif
        mob:getHPP() > 25 and
        mob:getHPP() <= 50 and
        mob:getMod(xi.mod.REGAIN) ~= 500
    then
        mob:setMod(xi.mod.REGAIN, 500)
    elseif mob:getHPP() > 50 and mob:getMod(xi.mod.REGAIN) ~= 750 then
        mob:setMod(xi.mod.REGAIN, 750)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        player:showText(mob, ID.text.SKY_GOD_OFFSET + 10)
        GetNPCByID(ID.npc.PORTAL_TO_SEIRYU):setAnimation(xi.anim.OPEN_DOOR)
    end
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.PORTAL_TO_SEIRYU):setAnimation(xi.anim.OPEN_DOOR)
end

return entity
