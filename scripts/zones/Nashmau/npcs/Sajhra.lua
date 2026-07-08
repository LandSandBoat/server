-----------------------------------
-- Area: Nashmau
--  NPC: Sajhra
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(220, player:getGil(), 100)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 220 and option == 256 then
        player:delKeyItem(xi.ki.SILVER_SEA_FERRY_TICKET)
    end
end

return entity
