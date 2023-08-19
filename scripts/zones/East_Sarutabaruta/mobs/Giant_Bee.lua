-----------------------------------
-- Area: East Sarutabaruta
--  Mob: Giant Bee
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 90, 1, xi.regime.type.FIELDS)
end

return entity
