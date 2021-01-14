-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Marid
-- Note: Place holder Mahishasura
-----------------------------------
local ID = require("scripts/zones/Bhaflau_Thickets/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.MAHISHASURA_PH, 5, 10800) -- 3 hours
end

return entity
