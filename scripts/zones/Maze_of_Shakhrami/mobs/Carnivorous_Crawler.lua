-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Carnivorous Crawler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 697, 2, tpz.regime.type.GROUNDS)
end

return entity
