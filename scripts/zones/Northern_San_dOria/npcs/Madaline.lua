-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Madaline
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local Telmoda_Madaline = player:getCharVar("Telmoda_Madaline_Event")
    if (Telmoda_Madaline ~= 1) then
        player:setCharVar(player, "Telmoda_Madaline_Event", 1)
        player:startEvent(531)
    else
        player:startEvent(617)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
