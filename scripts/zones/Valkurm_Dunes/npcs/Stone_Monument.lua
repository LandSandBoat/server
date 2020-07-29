-----------------------------------
-- Area: Valkurm Dunes
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos -311.299 -4.420 -138.878 103
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(900)
end

function onTrade(player, npc, trade)
    if (trade:getItemCount() == 1 and trade:hasItemQty(571, 1)) then
        player:tradeComplete()
        player:addItem(570)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 570)
        player:setCharVar("anExplorer-CurrentTablet", 0x00008)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
