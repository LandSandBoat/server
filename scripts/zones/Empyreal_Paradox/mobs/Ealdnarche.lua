-----------------------------------
-- Area: Emperial Paradox
--  Mob: Eald'narche
-- Apocalypse Nigh Final Fight
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.TELEPORT_CD, 30)
    mob:setMobMod(tpz.mobMod.TELEPORT_START, 988)
    mob:setMobMod(tpz.mobMod.TELEPORT_END, 989)
    mob:setMobMod(tpz.mobMod.TELEPORT_TYPE, 1)
    mob:setMod(tpz.mod.MDEF, 50);
end

entity.onMobSpawn = function(mob)
    mob:addMod(tpz.mod.EVA, 50)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
