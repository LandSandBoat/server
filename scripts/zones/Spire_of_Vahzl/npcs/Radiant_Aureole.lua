-----------------------------------
-- Area: Spire of Vahzl
--  NPC: Radiant Aureole
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(15)
end

function onEventUpdate(player, csid, option)
    -- printf("onUpdate CSID: %u", csid)
    -- printf("onUpdate RESULT: %u", option)
end

function onEventFinish(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)

    if (csid == 15 and option == 1) then
        player:setPos(-379.947, 48.045, 334.059, 192, 9) -- To Pso'Xja {R}
    end

end
