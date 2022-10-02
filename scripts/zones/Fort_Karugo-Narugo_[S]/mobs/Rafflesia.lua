-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--  Mob: Rafflesia
-- Note: PH for Kirtimukha
-----------------------------------
local ID = require("scripts/zones/Fort_Karugo-Narugo_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.KIRTIMUKHA_PH, 5, 3600) -- 1 hour
end

return entity
