-----------------------------------
-- Area: Nashmau
--  NPC: Abihaal
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(221, player:getGil(), 100)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 221 and option == 333 then
        player:delGil(100)
    end
end

return entity
