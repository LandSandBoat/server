-----------------------------------
-- Area: Cape Teriggan
--  Mob: Goblin Mercenary
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 105, 2, xi.regime.type.FIELDS)
end

return entity
