-----------------------------------
-- Area: La Theine Plateau
--  Mob: Mad Sheep
-----------------------------------
require("scripts/globals/regimes")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 69, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 70, 1, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end

return entity
