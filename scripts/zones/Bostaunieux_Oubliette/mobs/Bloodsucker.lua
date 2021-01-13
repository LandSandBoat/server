-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--  Mob: Bloodsucker
-- Note: This script will be loaded for both the NM and non-NM mobs of this name.
-- !pos -21.776 16.983 -231.477 167
-----------------------------------
local ID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    if mob:getID() == ID.mob.BLOODSUCKER then
        mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1) -- "Has an Additional Effect of Drain on normal attacks"
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.HP_DRAIN)
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 613, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    if mob:getID() == ID.mob.BLOODSUCKER then
        UpdateNMSpawnPoint(mob)
        mob:setRespawnTime(3600)
    end
end

return entity
