-----------------------------------
-- Area: Palborough Mines
--  NPC: Refiner Lever
-- Involved In Mission: Journey Abroad
-- !pos 180 -32 167 143
-----------------------------------
local ID = require("scripts/zones/Palborough_Mines/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local refinerOutput = player:getCharVar("refiner_output")

    if refinerOutput > 0 and player:getFreeSlotsCount() >= 1 then
        player:setCharVar("refiner_output", refinerOutput - 1)
        player:messageSpecial(ID.text.SOMETHING_FALLS_OUT_OF_THE_MACHINE)
        player:addItem(599)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 599, 1)
    elseif refinerOutput > 0 and player:getFreeSlotsCount() == 0 then
        player:messageSpecial(ID.text.YOU_CANT_CARRY_ANY_MORE_ITEMS)
    else
        player:messageSpecial(ID.text.THE_MACHINE_SEEMS_TO_BE_WORKING)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
