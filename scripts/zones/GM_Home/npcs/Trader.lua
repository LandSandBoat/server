-----------------------------------
-- Area: GM Home
--  NPC: Trader
-- Type: Debug NPC for testing trades.
-----------------------------------

function onTrade(player, npc, trade)
    if (trade:hasItemQty(4096, 1) and trade:getItemCount() == 1) then
        player:startEvent(126)
    end
end

function onTrigger(player, npc)
    player:startEvent(127)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
