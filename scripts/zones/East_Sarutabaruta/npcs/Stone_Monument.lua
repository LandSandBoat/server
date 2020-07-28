-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos 448.045 -7.808 319.980 116
-----------------------------------
local ID = require("scripts/zones/East_Sarutabaruta/IDs")
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(900)
end

function onTrade(player, npc, trade)
    if (trade:getItemCount() == 1 and trade:hasItemQty(571, 1)) then
        player:tradeComplete()
        player:addItem(570)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 570)
        player:setCharVar("anExplorer-CurrentTablet", 0x00800)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
