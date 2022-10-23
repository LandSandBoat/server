-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Genbu
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob, target)
    GetNPCByID(ID.npc.PORTAL_TO_GENBU):setAnimation(xi.anim.CLOSE_DOOR)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENWATER)
end

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, ID.text.SKY_GOD_OFFSET + 6)
    GetNPCByID(ID.npc.PORTAL_TO_GENBU):setAnimation(xi.anim.OPEN_DOOR)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.PORTAL_TO_GENBU):setAnimation(xi.anim.OPEN_DOOR)
end

return entity
