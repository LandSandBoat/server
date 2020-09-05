-----------------------------------
-- Area: Port San d'Oria
--  NPC: Leonora
-- Involved in Quest:
-- !pos -24 -8 15 232
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getZPos() >= 12) then
        player:startEvent(518)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
