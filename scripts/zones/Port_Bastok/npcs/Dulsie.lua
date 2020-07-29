-----------------------------------
-- Area: Port Bastok
--  NPC: Dulsie
-- Adventurer's Assistant
-- Working 100%
-------------------------------------
require("scripts/globals/settings")
local ID = require("scripts/zones/Port_Bastok/IDs")

function onTrade(player, npc, trade)

    if (trade:hasItemQty(536, 1) and trade:getItemCount() == 1) then
        player:startEvent(8)
    end

end

function onTrigger(player, npc)
    player:startEvent(7)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 8) then
        player:tradeComplete()
        player:addGil(GIL_RATE*50)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*50)
    end

end
