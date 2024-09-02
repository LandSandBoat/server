-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Ichorous Ire
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.JELLYBANE)
end

return entity
