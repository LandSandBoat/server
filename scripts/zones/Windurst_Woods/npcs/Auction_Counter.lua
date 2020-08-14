-----------------------------------
-- Area: Windurst Woods
--  NPC: Auction Counter
-----------------------------------
require("scripts/quests/tutorial")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.tutorial.onAuctionTrigger(player)
    player:sendMenu(3)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
