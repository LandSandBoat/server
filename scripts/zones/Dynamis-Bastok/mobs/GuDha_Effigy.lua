-----------------------------------
-- Area: Dynamis - Bastok
--  Mob: Gu'Dha Effigy
-- Note: Mega Boss
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.megaBossOnDeath(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 4401 })
end

return entity
