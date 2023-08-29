-----------------------------------
-- Area: Konschtat Highlands
--   NM: Highlander Lizard
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    -- Higher TP Gain per melee hit than normal lizards.
    -- It is definitly NOT regain.
    mob:addMod(xi.mod.STORETP, 25) -- May need adjustment.

    -- Hits especially hard for his level, even by NM standards.
    mob:addMod(xi.mod.ATT, 50) -- May need adjustment along with cmbDmgMult in mob_pools.sql
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 206)
    -- I think he still counts the FoV pages? Most NM's do not though.
    xi.regime.checkRegime(player, mob, 20, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 82, 2, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(1200, 1800)) -- 20~30 min repop
end

return entity
