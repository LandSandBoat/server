-----------------------------------
-- Area: La Theine Plateau
--  Mob: Poison Bat
-----------------------------------
require("scripts/globals/regimes")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 71, 1, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end

return entity
