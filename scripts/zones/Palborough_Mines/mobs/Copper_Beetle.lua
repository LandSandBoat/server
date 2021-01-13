-----------------------------------
-- Area: Palborough Mines
--  Mob: Copper Beetle
-- Note: PH for Bu'Ghi Howlblade
-----------------------------------
local ID = require("scripts/zones/Palborough_Mines/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BU_GHI_HOWLBLADE_PH, 10, 3600) -- 1 hour
end

return entity
