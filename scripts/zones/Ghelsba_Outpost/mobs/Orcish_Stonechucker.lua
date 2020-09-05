-----------------------------------
-- Area: Ghelsba Outpost (140)
--  Mob: Orcish Stonechucker
-- Note: PH for Thousandarm Deshglesh
-----------------------------------
local ID = require("scripts/zones/Ghelsba_Outpost/IDs")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.THOUSANDARM_DESHGLESH_PH, 5, math.random(3600, 10800)) -- 1 to 3 hours
end
