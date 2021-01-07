-----------------------------------
-- Area: Pashhow Marshlands
--  Mob: Carnivorous Crawler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 23, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 24, 2, tpz.regime.type.FIELDS)
end

return entity
