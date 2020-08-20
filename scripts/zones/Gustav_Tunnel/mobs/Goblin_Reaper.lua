-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Goblin Reaper
-- Note: Place holder Goblinsavior Heronox
-----------------------------------
local ID = require("scripts/zones/Gustav_Tunnel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 764, 3, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 765, 3, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.GOBLINSAVIOR_HERONOX_PH, 5, math.random(10800, 18000)) -- 3 to 5 hours
end
