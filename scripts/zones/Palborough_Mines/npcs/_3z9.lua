-----------------------------------
-- Area: Palborough Mines
--  NPC: Refiner Lever
-- Involved In Mission: Journey Abroad
-- !pos 180 -32 167 143
-----------------------------------
local ID = require("scripts/zones/Palborough_Mines/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local refiner_output = player:getCharVar("refiner_output")

    if refiner_output > 0 and player:getFreeSlotsCount() >= 1 then
        player:setCharVar("refiner_output", refiner_output - 1)
        player:messageSpecial(ID.text.SOMETHING_FALLS_OUT_OF_THE_MACHINE)
        player:addItem(599)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 599, 1)
    elseif refiner_output > 0 and player:getFreeSlotsCount() == 0 then
        player:messageSpecial(ID.text.YOU_CANT_CARRY_ANY_MORE_ITEMS)
    else
        player:messageSpecial(ID.text.THE_MACHINE_SEEMS_TO_BE_WORKING)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
