-----------------------------------
-- Area: Lower Jeuno
--  NPC: Yatniel
-- Type: Standard NPC
-- !pos -66.817 -7 -126.594 245
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    hittingTheMarquisateYatnielCS = player:getCharVar("hittingTheMarquisateYatnielCS")

    if (trade:hasItemQty(17314, 4) and trade:getItemCount() == 4) then -- Trade quake grenades X4
        player:startEvent(10031)
    end

end

entity.onTrigger = function(player, npc)

    hittingTheMarquisateYatnielCS = player:getCharVar("hittingTheMarquisateYatnielCS")

    if (hittingTheMarquisateYatnielCS == 1) then
        player:startEvent(10029, 0, 17314)
    elseif (hittingTheMarquisateYatnielCS == 2) then
        player:startEvent(10030, 0, 17314)
    elseif (hittingTheMarquisateYatnielCS == 3) then
        player:startEvent(10032)
    else
        player:startEvent(10028)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 10029) then
        player:setCharVar("hittingTheMarquisateYatnielCS", 2)
    elseif (csid == 10031) then
        player:setCharVar("hittingTheMarquisateYatnielCS", 3)
        player:tradeComplete()
    end



end

return entity
