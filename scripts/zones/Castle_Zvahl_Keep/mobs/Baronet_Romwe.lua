-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Baronet Romwe
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 353)
    player:addTitle(xi.title.HELLSBANE)
end

return entity
