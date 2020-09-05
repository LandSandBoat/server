-----------------------------------
-- Area: Beadeaux (254)
--  Mob: Emerald Quadav
-- Note: PH for Ga'Bhu Unvanquished
-----------------------------------
local ID = require("scripts/zones/Beadeaux/IDs")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.GA_BHU_UNVANQUISHED_PH, 10, 3600) -- 1 hour
end
