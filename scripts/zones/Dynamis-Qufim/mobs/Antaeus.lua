-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Antaeus
-- Note: Mega Boss
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.megaBossOnDeath(mob, player, optParams)
end

return entity
