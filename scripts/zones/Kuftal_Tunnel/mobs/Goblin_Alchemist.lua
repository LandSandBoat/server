-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Goblin Alchemist
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 740, 2, xi.regime.type.GROUNDS)
end

return entity
