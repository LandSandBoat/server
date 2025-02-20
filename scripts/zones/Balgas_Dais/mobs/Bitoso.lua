-----------------------------------
-- Area: Balga's Dais
--  Mob: Bitoso
-- BCNM: Creeping Doom
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMobMod(xi.mobMod.HP_HEAL_CHANCE, 90)
    mob:setMobMod(xi.mobMod.HEAL_CHANCE, 100)
    mob:setMod(xi.mod.REGEN, 0)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 13)
end

entity.onMobFight = function(mob, target)
end

entity.onMagicHit = function(caster, target, spell)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
