-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Sea Puk
-- Note: Place holder Nis Puk
-----------------------------------
local ID = require("scripts/zones/Bhaflau_Thickets/IDs")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.NIS_PUK_PH, 5, 43200) -- 12 hours
end
