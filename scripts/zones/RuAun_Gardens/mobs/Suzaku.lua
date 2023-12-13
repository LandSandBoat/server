-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Suzaku
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob, target)
    mob:setMod(xi.mod.SILENCERES, 90)
    mob:addMod(xi.mod.ATT, 155)
    mob:addMod(xi.mod.DEF, 94)
    mob:setMod(xi.mod.EVA, 377)
    mob:addMod(xi.mod.VIT, 77)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
    GetNPCByID(ID.npc.PORTAL_TO_SUZAKU):setAnimation(xi.anim.CLOSE_DOOR)
    mob:setMagicCastingEnabled(false)
end

entity.onMobEngaged = function(mob, target)
    mob:messageText(mob, ID.text.SKY_GOD_OFFSET + 7)
    mob:timer(5000, function(mobArg)
        mobArg:setMagicCastingEnabled(true)
    end)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENFIRE)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        player:showText(mob, ID.text.SKY_GOD_OFFSET + 8)
        GetNPCByID(ID.npc.PORTAL_TO_SUZAKU):setAnimation(xi.anim.OPEN_DOOR)
    end
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.PORTAL_TO_SUZAKU):setAnimation(xi.anim.OPEN_DOOR)
end

return entity
