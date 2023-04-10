-----------------------------------
-- Area: Ranguemont Pass
--  NPC: Perchond
-- !pos -182.844 4 -164.948 166
-----------------------------------
local ID = require("scripts/zones/Ranguemont_Pass/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if trade:hasItemQty(1107, 1) and trade:getItemCount() == 1 then -- glitter sand
        local sinHunting = player:getCharVar("sinHunting")    -- RNG AF1

        if sinHunting == 2 then
            player:startEvent(5)
        end
    end
end

entity.onTrigger = function(player, npc)
    local sinHunting = player:getCharVar("sinHunting")    -- RNG AF1

    if sinHunting == 1 then
        player:startEvent(3, 0, 1107)
    else
        player:startEvent(2)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 3 then
        player:setCharVar("sinHunting", 2)
    elseif csid == 5 then
        player:tradeComplete()
        player:addKeyItem(xi.ki.PERCHONDS_ENVELOPE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.PERCHONDS_ENVELOPE)
        player:setCharVar("sinHunting", 3)
    end
end

return entity
