-----------------------------------
-- Area: Spire of Mea
--  NPC: Radiant Aureole
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(14)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)
    if (csid==14 and option==1) then
        player:setPos(179.92, 35.15, 260.137, 64, 117)        -- To Tahrongi Canyon {R}
    end
end
