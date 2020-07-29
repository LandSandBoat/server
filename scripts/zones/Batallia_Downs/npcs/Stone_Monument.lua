-----------------------------------
-- Area: Batallia Downs
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos 185.669 9.049 -614.025 105
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(900)
end

function onTrade(player, npc, trade)
    if (trade:getItemCount() == 1 and trade:hasItemQty(571, 1)) then
        player:tradeComplete()
        player:addItem(570)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 570)
        player:setCharVar("anExplorer-CurrentTablet", 0x10000)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
