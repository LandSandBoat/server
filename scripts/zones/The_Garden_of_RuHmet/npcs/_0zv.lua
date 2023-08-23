-----------------------------------
-- Area: The Garden of Ru'Hmet
--  NPC: particle gate
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.BRAND_OF_TWILIGHT) then
        player:startEvent(111)
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 111 and option == 1 then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BRAND_OF_TWILIGHT)
        player:addKeyItem(xi.ki.BRAND_OF_TWILIGHT)
    end
end

return entity
