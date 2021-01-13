-----------------------------------
-- Area: West Ronfaure(100)
--  Mob: Scarab Beetle
-- Note: Place holder for Fungus Beetle
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 3, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 4, 2, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.FUNGUS_BEETLE_PH, 10, math.random(900, 10800)) -- 15 minutes to 3 hours
end

return entity
