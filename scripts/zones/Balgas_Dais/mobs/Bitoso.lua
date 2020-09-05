-----------------------------------
-- Area: Balga's Dais
--  Mob: Bitoso
-- BCNM: Creeping Doom
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.HP_HEAL_CHANCE, 90)
    mob:setMobMod(tpz.mobMod.HEAL_CHANCE, 100)
    mob:setMod(tpz.mod.REGEN, 0)
end

function onMobSpawn(mob)
mob:setMobMod(tpz.mobMod.MAGIC_COOL, 20)
mob:setMobMod(tpz.mobMod.SOUND_RANGE, 13)
end

function onMobFight (mob, target)

end

function onMagicHit(caster, target, spell)

end

function onMobDeath(mob, player, isKiller)
end