-----------------------------------
-- Area: Lower Jeuno
--  NPC: Derrick
-- Involved in Quests and finish : Save the Clock Tower
-- !pos -32 -1 -7 245
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.AIRSHIP_PASS) then
        player:startEvent(230, 12)
    else
        player:startEvent(230, 14)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 230 and option == 10 then
        if player:delGil(500000) then
            player:addKeyItem(xi.ki.AIRSHIP_PASS)
            player:updateEvent(0, 1)
        else
            player:updateEvent(0, 0)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 230 and option == 10 then
        if player:hasKeyItem(xi.ki.AIRSHIP_PASS) then
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.AIRSHIP_PASS)
        end
    end
end

return entity
