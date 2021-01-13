-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Fly Agaric
-- Note: PH for Donggu
-----------------------------------
local ID = require("scripts/zones/Ordelles_Caves/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 656, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.DONGGU_PH, 10, 3600) -- 1 hour
end

return entity
