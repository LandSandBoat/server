-----------------------------------
-- Area: Jugner Forest
--  NPC: Alexius
-- Involved in Quest: A purchase of Arms & Sin Hunting
-- !pos 105 1 382 104
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.WEAPONS_ORDER) then
        player:startEvent(5)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 5 then
        player:delKeyItem(xi.ki.WEAPONS_ORDER)
        player:addKeyItem(xi.ki.WEAPONS_RECEIPT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WEAPONS_RECEIPT)
    end
end

return entity
