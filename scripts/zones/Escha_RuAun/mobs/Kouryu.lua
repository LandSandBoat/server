-----------------------------------
-- Area: Sky 2.0
--   NM: Kouryu
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function( mob )
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SILENCERES, 10000)
    mob:setMod(xi.mod.SLEEPRES, 10000)
    mob:setMod(xi.mod.PETRIFYRES, 10000)
    mob:setMod(xi.mod.BINDRES, 10000)
    mob:setMod(xi.mod.CHARMRES, 10000)
    mob:setMod(xi.mod.PARALYZERES, 10000)
    mob:setMod(xi.mod.STUNRES, 10000)
    mob:setMod(xi.mod.BINDRES, 10000)
    mob:setMod(xi.mod.GRAVITYRES, 10000)
    mob:addMod(xi.mod.MDEF, mob:getMod(xi.mod.MDEF) + 200)
    mob:setDropID(3989)
    mob:setHP(mob:getMaxHP() / 2)
end

entity.onMobFight = function( mob, target )
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function( mob )
end

return entity
