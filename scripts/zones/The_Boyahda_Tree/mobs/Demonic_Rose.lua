-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Demonic Rose
-- Note: Placeholder V. Vivian
-----------------------------------
local ID = require("scripts/zones/The_Boyahda_Tree/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.VOLUPTUOUS_VIVIAN_PH, 10, math.random(57600, 86400)) -- 16 to 24 hours
end
