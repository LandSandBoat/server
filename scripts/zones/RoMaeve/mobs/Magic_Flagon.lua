-----------------------------------
-- Area: RoMaeve
--  Mob: Magic Flagon
-- Note: PH for Nightmare Vase and Rogue Receptacle
-----------------------------------
local ID = require("scripts/zones/RoMaeve/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 120, 1, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.NIGHTMARE_VASE_PH, 10, 3600) -- 1 hour
    tpz.mob.phOnDespawn(mob, ID.mob.ROGUE_RECEPTACLE_PH, 10, 7200) -- 2 hour
end

return entity
