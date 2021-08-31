-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Ice Elemental
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 750, 1, xi.regime.type.GROUNDS)
end

return entity
