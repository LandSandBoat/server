-----------------------------------
-- Area: Kazham
--  NPC: Ney Hiparujah
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(251 + player:getFameLevel(KAZHAM))
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
