-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Tazhaal
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(222, player:getGil(), 100)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 222 and option == 256 then
        player:delKeyItem(xi.ki.SILVER_SEA_FERRY_TICKET)
    end
end

return entity
