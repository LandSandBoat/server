-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Sea Puk
-- Note: Place holder Nis Puk
-----------------------------------
local ID = require("scripts/zones/Bhaflau_Thickets/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.NIS_PUK_PH, 5, 43200) -- 12 hours
end

return entity
