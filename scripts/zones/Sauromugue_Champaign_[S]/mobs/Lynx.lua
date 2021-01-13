-----------------------------------
-- Area: Sauromugue Champaign [S]
--  Mob: Lynx
-- Note: PH for Balam-Quitz
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BALAM_QUITZ_PH, 10, 3600) -- 1 hour
end

return entity
