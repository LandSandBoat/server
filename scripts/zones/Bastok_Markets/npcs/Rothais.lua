-----------------------------------
-- Area: Bastok Markets
--  NPC: Rothais
-- Involved in Quest: Gourmet
-----------------------------------
function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

vanatime = VanadielHour()

    if (vanatime>=18 or vanatime<6) then
        player:startEvent(204)
    elseif (vanatime>=6 and vanatime<12) then
        player:startEvent(205)
    else
        player:startEvent(206)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
