-----------------------------------
-- Area: Emperial Paradox
--  Mob: Eald'narche
-- Apocalypse Nigh Final Fight
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.TELEPORT_CD, 30)
    mob:setMobMod(xi.mobMod.TELEPORT_START, 988)
    mob:setMobMod(xi.mobMod.TELEPORT_END, 989)
    mob:setMobMod(xi.mobMod.TELEPORT_TYPE, 1)
    mob:setMod(xi.mod.MDEF, 50)
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.EVA, 50)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
