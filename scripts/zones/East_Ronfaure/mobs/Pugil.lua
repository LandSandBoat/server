-----------------------------------
-- Area: East Ronfaure
--  Mob: Pugil
-- Note: PH for Swamfisk
-----------------------------------
local ID = require("scripts/zones/East_Ronfaure/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 64, 1, tpz.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.SWAMFISK_PH, 7, math.random(3600, 10800)) -- 1 to 3 hours
end

return entity
