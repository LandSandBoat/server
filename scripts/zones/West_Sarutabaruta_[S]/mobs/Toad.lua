-----------------------------------
-- Area: West Sarutabaruta [S]
--  Mob: Toad
-- Note: Place holder Ramponneau
-----------------------------------
local ID = require("scripts/zones/West_Sarutabaruta_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.RAMPONNEAU_PH, 20, 5400) -- 90 minutes
end

return entity
