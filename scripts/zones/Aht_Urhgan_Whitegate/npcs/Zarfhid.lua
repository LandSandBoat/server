-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Zarfhid
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(220)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 220 and option == 333 then
        player:delKeyItem(xi.ki.FERRY_TICKET)
    end
end

return entity
