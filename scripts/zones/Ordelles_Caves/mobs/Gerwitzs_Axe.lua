-----------------------------------
-- Area: Ordelles Caves
--   NM: Gerwitz's Axe
-- !pos -51 0.1 3 193
-----------------------------------
local ordellesID = zones[xi.zone.ORDELLES_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
    mob:setMod(xi.mod.ACC, 700) -- He has very VERY high accuracy
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TP_DRAIN, { chance = 5, power = (math.random(250, 600)) })
end

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, ordellesID.text.GERWITZS_AXE_DIALOG)
end

return entity
