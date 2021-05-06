-----------------------------------
-- Area: Misareaux Coast
--  NPC: Dilapidated Gate
-- Note: Entrance to Misareaux Coast
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(553)
    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)


end

return entity
