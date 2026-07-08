-----------------------------------
-- Area: Mhaura
--  NPC: Felisa
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Outside dock zone.
    if player:getZPos() >= 39 then
        player:startEvent(221, player:getGil(), 100)

    -- Inside dock zone.
    else
        player:startEvent(235)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 221 and option == 333 then
        player:addKeyItem(xi.ki.FERRY_TICKET)
        player:delGil(100)
    end
end

return entity
