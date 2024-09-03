-----------------------------------
-- Area: RoMaeve
--  Mob: Cursed Puppet
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 121, 1, xi.regime.type.FIELDS)
end

return entity
