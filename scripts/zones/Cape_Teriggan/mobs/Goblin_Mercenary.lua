-----------------------------------
-- Area: Cape Teriggan
--  Mob: Goblin Mercenary
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 105, 2, xi.regime.type.FIELDS)
end

return entity
