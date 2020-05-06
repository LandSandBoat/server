-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: Tome of Magic
-- Involved In Windurst Mission 7-2 (Optional Dialogue)
-- !pos 346 0 343 159 <many>
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local cs = math.random(20, 22)
    player:startEvent(cs)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
