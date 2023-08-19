-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Champaign Coeurl
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 98, 1, xi.regime.type.FIELDS)
end

return entity
