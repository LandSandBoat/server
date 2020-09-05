-----------------------------------
-- Area: Spire of Holla
--  NPC: Radiant Aureole
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(14)
end

function onEventUpdate(player, csid, option)
    -- printf("onUpdate CSID: %u", csid)
    -- printf("onUpdate RESULT: %u", option)
end

function onEventFinish(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)

    if (csid == 14 and option == 1) then
        player:setPos(340.082, 19.103, -59.979, 127, 102)     -- To La Theine Plateau {R}
    end

end
