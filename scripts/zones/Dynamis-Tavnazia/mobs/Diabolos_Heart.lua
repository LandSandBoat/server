-----------------------------------
-- Area: Dynamis-Tavnazia
--  Mob: Diabolos Heart
-- Note: Mega Boss
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.megaBossOnDeath(mob, player, optParams)
    player:addTitle(xi.title.NIGHTMARE_AWAKENER)
end

return entity
