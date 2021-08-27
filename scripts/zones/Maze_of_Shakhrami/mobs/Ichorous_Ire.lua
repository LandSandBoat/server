-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Ichorous Ire
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.JELLYBANE)
end

return entity
