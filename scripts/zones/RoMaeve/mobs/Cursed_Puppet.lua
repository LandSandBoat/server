-----------------------------------
-- Area: RoMaeve
--  Mob: Cursed Puppet
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 121, 1, xi.regime.type.FIELDS)
end

return entity
