-----------------------------------
-- Area: Buburimu Peninsula
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos 320.755 -4.000 368.722 118
-----------------------------------
local ID = require("scripts/zones/Buburimu_Peninsula/IDs")
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(900)
end

function onTrade(player, npc, trade)
    if (trade:getItemCount() == 1 and trade:hasItemQty(571, 1)) then
        player:tradeComplete()
        player:addItem(570)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 570)
        player:setCharVar("anExplorer-CurrentTablet", 0x02000)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
