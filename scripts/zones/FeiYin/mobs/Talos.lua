-----------------------------------
-- Area: FeiYin
--  Mob: Talos
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 713, 2, xi.regime.type.GROUNDS)
end

return entity
