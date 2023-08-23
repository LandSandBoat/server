-----------------------------------
-- Area: The Sanctuary of ZiTah
--  Mob: Ogrefly
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 114, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 115, 2, xi.regime.type.FIELDS)
end

return entity
