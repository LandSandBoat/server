-----------------------------------
-- Area: Konschtat Highlands
--   NM: Highlander Lizard
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
require("scripts/globals/status")
require("scripts/quests/tutorial")
-----------------------------------

function onMobInitialize(mob)
    -- Higher TP Gain per melee hit than normal lizards.
    -- It is definitly NOT regain.
    mob:addMod(tpz.mod.STORETP, 25) -- May need adjustment.

    -- Hits especially hard for his level, even by NM standards.
    mob:addMod(tpz.mod.ATT, 50) -- May need adjustment along with cmbDmgMult in mob_pools.sql
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 206)
    -- I think he still counts the FoV pages? Most NM's do not though.
    tpz.regime.checkRegime(player, mob, 20, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 82, 2, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(1200, 1800)) -- 20~30 min repop
end
