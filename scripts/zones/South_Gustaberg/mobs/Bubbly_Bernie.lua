-----------------------------------
-- Area: South Gustaberg
--   NM: Bubbly Bernie
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 80, 2, xi.regime.type.FIELDS)
end

return entity
