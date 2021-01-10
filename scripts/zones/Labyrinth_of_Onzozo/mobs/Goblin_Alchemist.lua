-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Goblin Alchemist
-- Note: Place holder Soulstealer Skullnix
-----------------------------------
local ID = require("scripts/zones/Labyrinth_of_Onzozo/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 771, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 772, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 774, 2, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.SOULSTEALER_SKULLNIX_PH, 5, math.random(7200, 10800)) -- 2 to 3 hours
end

return entity
