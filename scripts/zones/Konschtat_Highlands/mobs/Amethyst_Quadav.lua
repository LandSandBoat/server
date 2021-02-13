-----------------------------------
-- Area: Konschtat Highlands
--  Mob: Amethyst Quadav
-----------------------------------
require("scripts/globals/regimes")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 83, 1, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end

return entity
