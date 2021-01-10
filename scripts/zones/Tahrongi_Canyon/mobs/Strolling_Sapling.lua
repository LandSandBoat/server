-----------------------------------
-- Area: Tahrongi Canyon
--  Mob: Strolling Sapling
-----------------------------------
require("scripts/globals/regimes")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 30, 1, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end

return entity
