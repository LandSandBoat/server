-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Houilloume
-- !zone 80
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(103) -- it says player:startEvent(103)
    -- the player:startEvent basically means start CutScene
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
