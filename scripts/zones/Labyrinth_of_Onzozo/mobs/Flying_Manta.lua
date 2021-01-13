-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Flying Manta
-- Note: PH for Lord of Onzozo and Peg Powler
-----------------------------------
local ID = require("scripts/zones/Labyrinth_of_Onzozo/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 774, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.LORD_OF_ONZOZO_PH, 4, math.random(75600, 86400)) -- 18 to 24 hours
    tpz.mob.phOnDespawn(mob, ID.mob.PEG_POWLER_PH, 4, math.random(7200, 57600)) -- 2 to 16 hours
end

return entity
