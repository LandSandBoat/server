-----------------------------------
-- Area: Grauberg [S]
--  Mob: Grauberg Hippogryph
-- Note: PH for Kotan-kor Kamuy
-----------------------------------
local ID = require("scripts/zones/Grauberg_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.KOTAN_KOR_KAMUY_PH, 5, 10800) -- 3 hours
end

return entity
