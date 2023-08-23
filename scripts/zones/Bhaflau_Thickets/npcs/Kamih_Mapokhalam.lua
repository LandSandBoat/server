-----------------------------------
-- Area: Bhaflau Thickets
--  NPC: Kamih Mapokhalam
-- 20 -30 597 z 52
-----------------------------------
local ID = require("scripts/zones/Bhaflau_Thickets/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local count = trade:getItemCount()

    if count == 1 and trade:hasItemQty(2185, 1) then -- Silver
        player:tradeComplete()
        player:startEvent(121)
    elseif count == 3 and trade:hasItemQty(2186, 3) then -- Mythril
        if player:hasKeyItem(xi.ki.MAP_OF_ALZADAAL_RUINS) then
            player:startEvent(147)
        else
            player:startEvent(146)
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getZPos() < 597 then
        player:startEvent(120)
    else
        player:startEvent(122)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 121 then
        player:setPos(325.137, -3.999, -619.968, 0, 72) -- To Alzadaal Undersea Ruins G-8 (R)
    elseif csid == 146 then
        player:tradeComplete()
        player:addKeyItem(xi.ki.MAP_OF_ALZADAAL_RUINS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MAP_OF_ALZADAAL_RUINS)
    end
end

return entity
