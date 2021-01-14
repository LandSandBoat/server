-----------------------------------
-- Area: La Theine Plateau
--  Mob: Huge Wasp
-----------------------------------
require("scripts/globals/regimes")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 5, 2, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end

return entity
