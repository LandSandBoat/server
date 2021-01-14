-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Jelly
-- Note: PH for Agar Agar
-----------------------------------
local ID = require("scripts/zones/Ordelles_Caves/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 659, 2, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.AGAR_AGAR_PH, 5, 3600) -- 1 hour
end

return entity
