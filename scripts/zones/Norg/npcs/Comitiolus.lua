-----------------------------------
-- Area: Norg
--  NPC: Comitiolus
-- Standard Info NPC
-- !pos 100 -7 -13 252
-----------------------------------
require("scripts/globals/npc_util")

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, { 1695, 4297, 4506 }) -- Habaneros, Black Curry, Mutton Tortilla
        and player:getCharVar("TuningOut_Progress") == 6
    then
        player:startEvent(207, 0, 1695) -- Receives spicy food, mentions only one of them
    end
end

function onTrigger(player, npc)
    local tuningOutProgress = player:getCharVar("TuningOut_Progress")

    if tuningOutProgress == 6 then
        player:startEvent(206) -- Declines request to speak to Kamui
    elseif tuningOutProgress == 7 then
        player:startEvent(208) -- Repeat hint for player to go to Beaucedine Glacier

    else
        player:startEvent(72)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 207 then
        player:tradeComplete()
        player:setCharVar("TuningOut_Progress", 7)
    end
end
