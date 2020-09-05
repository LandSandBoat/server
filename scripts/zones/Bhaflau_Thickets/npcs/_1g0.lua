-----------------------------------
-- Area: Bhaflau Thickets
--  NPC: Postern (door _1g0)
-- Shortcut back into Aht Urgan Whitegate, North Harbor
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(502)
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 502 and option == 1) then
        player:setPos(-37, 1, 56, 0, 50)
    end

end
