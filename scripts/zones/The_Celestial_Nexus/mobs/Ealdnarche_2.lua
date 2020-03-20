-----------------------------------
-- Area: The Celestial Nexus
--  Mob: Eald'narche (Phase 2)
-- Zilart Mission 16 BCNM Fight
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobInitialize(mob)
    -- 60% fast cast, -75% physical damage taken, 10tp/tick regain, no standback
    mob:addMod(tpz.mod.UFASTCAST, 60)
    mob:addMod(tpz.mod.UDMGPHYS, -75)
    mob:addMod(tpz.mod.REGAIN, 100)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK,-1)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GA_CHANCE,25)
end

function onMobDeath(mob, player, isKiller)
    mob:getBattlefield():setLocalVar("loot", 0)
end
