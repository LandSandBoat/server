-----------------------------------
-- Area: Emperial Paradox
--  Mob: Eald'narche
-- Apocalypse Nigh Final Fight
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.TELEPORT_CD, 30)
    mob:setMobMod(tpz.mobMod.TELEPORT_START, 988)
    mob:setMobMod(tpz.mobMod.TELEPORT_END, 989)
    mob:setMobMod(tpz.mobMod.TELEPORT_TYPE, 1)
    mob:setMod(tpz.mod.MDEF, 50);
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.EVA, 50)
end

function onMobDeath(mob, player, isKiller)
end
