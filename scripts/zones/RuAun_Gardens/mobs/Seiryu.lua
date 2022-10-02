-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Seiryu
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SILENCERES, 90)
    mob:addMod(xi.mod.ATTP, 10)
    mob:addMod(xi.mod.EVA, 50)
    mob:addMod(xi.mod.VIT, 84)
    mob:addMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setDamage(145)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
end

entity.onMobSpawn = function(mob ,target)
    GetNPCByID(ID.npc.PORTAL_TO_SEIRYU):setAnimation(xi.anim.CLOSE_DOOR)
    mob:SetMagicCastingEnabled(false)
end

entity.onMobEngaged = function(mob, target)
    mob:messageText(mob, ID.text.SKY_GOD_OFFSET + 9)
    mob:timer(5000, function(mobArg)
        mobArg:SetMagicCastingEnabled(true)
    end)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO)
end

entity.onMobDeath = function(mob, player, isKiller)
    if isKiller then
        mob:messageText(mob, ID.text.SKY_GOD_OFFSET + 10)
        GetNPCByID(ID.npc.PORTAL_TO_SEIRYU):setAnimation(xi.anim.OPEN_DOOR)
    end
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.PORTAL_TO_SEIRYU):setAnimation(xi.anim.OPEN_DOOR)
end

return entity
