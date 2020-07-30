-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Mafwahb
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local LuckOfTheDraw = player:getCharVar("LuckOfTheDraw")

    if LuckOfTheDraw ==1 then
        player:startEvent(548)
        player:setCharVar("LuckOfTheDraw", 2)
    else
        player:startEvent(647)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
