-----------------------------------
-- Area: Palborough Mines
--  Mob: Veteran Quadav
-- Note: PH for Zi'Ghi Boneeater
-----------------------------------
local ID = require("scripts/zones/Palborough_Mines/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.ZI_GHI_BONEEATER_PH, 20, 3600) -- 1 hour
end

return entity
