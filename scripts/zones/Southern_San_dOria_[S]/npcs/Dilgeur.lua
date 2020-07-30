-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Dilgeur                 -- Misnamed NPC, name is Crochepallade when it should be Dilgeur, swap pos with the NPC at -46 2 -8
-- !pos 22 2 3 80
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(330)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
