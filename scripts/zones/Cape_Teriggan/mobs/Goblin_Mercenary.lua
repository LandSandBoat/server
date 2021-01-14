-----------------------------------
-- Area: Cape Teriggan
--  Mob: Goblin Mercenary
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 105, 2, tpz.regime.type.FIELDS)
end

return entity
