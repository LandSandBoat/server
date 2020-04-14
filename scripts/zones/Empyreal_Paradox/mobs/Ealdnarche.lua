-----------------------------------
-- Area: Emperial Paradox
--  Mob: Eald'narche
-- Apocalypse Nigh Final Fight
-- TODO:
--   Initially facing the wrong direction.
--   Highly evasive. Sushi and/or Madrigal recommended.
--   Very high magic defense (e.g., Thunder IV ~65 dmg).
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.TELEPORT_CD, 30)
    mob:setMobMod(tpz.mobMod.TELEPORT_START, 988)
    mob:setMobMod(tpz.mobMod.TELEPORT_END, 989)
    mob:setMobMod(tpz.mobMod.TELEPORT_TYPE, 1)
end

function onMobDeath(mob, player, isKiller)
end
