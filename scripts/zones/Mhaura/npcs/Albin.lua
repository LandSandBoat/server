-----------------------------------
-- Area: Mhaura
--  NPC: Albin
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Outside dock zone.
    if player:getZPos() >= 39 then
        player:startEvent(229)

    -- Inside dock zone.
    else
        player:startEvent(220)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 220 and option == 256 then
        player:delKeyItem(xi.ki.FERRY_TICKET)
    end
end

return entity
