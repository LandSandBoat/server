-----------------------------------
-- Area: Batallia Downs
--  Mob: Evil Weapon
-- Note: PH for Prankster Maverix
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.PRANKSTER_MAVERIX_PH, 5, 3600) -- 1 hour
end

return entity
