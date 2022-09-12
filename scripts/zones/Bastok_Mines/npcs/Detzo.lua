-----------------------------------
-- Area: Bastok Mines
--  NPC: Detzo
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("theTalekeeperGiftCS") == 1 then
        player:startEvent(171)
        player:setCharVar("theTalekeeperGiftCS", 2)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
