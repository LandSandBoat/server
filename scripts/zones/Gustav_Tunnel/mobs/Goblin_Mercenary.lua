-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Goblin Mercenary
-- Note: Place holder Wyvernpoacher Drachlox
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
    tpz.mob.phOnDespawn(mob, ID.mob.WYVERNPOACHER_DRACHLOX_PH, 5, math.random(7200, 28800)) -- 2 to 8 hours
end
