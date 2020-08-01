-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Arvilauge
-- Optional Involvement in Quest: A Squire's Test II
-- !pos -11 1 -94 230
-------------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    player:showText(npc, 11076)--temp dialog
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
