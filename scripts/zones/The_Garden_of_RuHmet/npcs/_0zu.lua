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
    if not player:hasKeyItem(xi.ki.BRAND_OF_DAWN) then
        player:startEvent(110)
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 110 and option == 1 then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BRAND_OF_DAWN)
        player:addKeyItem(xi.ki.BRAND_OF_DAWN)
    end
end

return entity
