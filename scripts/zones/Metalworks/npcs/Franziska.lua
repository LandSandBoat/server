-----------------------------------
-- Area: Metalworks
--  NPC: Franziska
-- Type: Standard Info NPC
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("OptionalcsCornelia") == 1 then
        player:startEvent(777)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 777 then
        player:setCharVar("OptionalcsCornelia", 0)
    end
end

return entity
