-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Atiza
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(223, player:getGil(), 100)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 223 and
        option == 333 and
        player:delGil(100)
    then
        player:addKeyItem(xi.keyItem.SILVER_SEA_FERRY_TICKET)
    end
end

return entity
