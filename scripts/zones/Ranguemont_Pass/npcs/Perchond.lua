-----------------------------------
-- Area: Ranguemont Pass
--  NPC: Perchond
-- !pos -182.844 4 -164.948 166
-----------------------------------
local ID = require("scripts/zones/Ranguemont_Pass/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)

    if (trade:hasItemQty(1107, 1) and trade:getItemCount() == 1) then -- glitter sand
        local SinHunting = player:getCharVar("sinHunting")    -- RNG AF1
        if (SinHunting == 2) then
            player:startEvent(5)
        end
    end

end

function onTrigger(player, npc)

    local SinHunting = player:getCharVar("sinHunting")    -- RNG AF1

    if (SinHunting == 1) then
        player:startEvent(3, 0, 1107)
    else
        player:startEvent(2)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 3) then
        player:setCharVar("sinHunting", 2)
    elseif (csid == 5) then
        player:tradeComplete()
        player:addKeyItem(tpz.ki.PERCHONDS_ENVELOPE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PERCHONDS_ENVELOPE)
        player:setCharVar("sinHunting", 3)
    end

end
