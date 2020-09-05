-----------------------------------
-- Area: Caedarva Mire
--  NPC: Kwadaaf
-- Type: Entry to Alzadaal Undersea Ruins
-- !pos -639.000 12.323 -260.000 79
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)

    if (trade:getItemCount() == 1 and trade:hasItemQty(2185, 1)) then -- Silver
        player:tradeComplete()
        player:startEvent(223)
    end

end

function onTrigger(player, npc)

    if (player:getXPos() < -639) then
        player:startEvent(222)
    else
        player:startEvent(224)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 223) then
        player:setPos(-235, -4, 220, 0, 72)
    end

end
