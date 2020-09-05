-----------------------------------
-- Area: Bastok Markets
--  NPC: Ardea
-- !pos -198 -6 -69 235
-- Involved in quests: Chasing Quotas, Rock Racketeer
-- Standard Info NPC
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local RockRacketeer = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.ROCK_RACKETEER)
    local Quotas_Status = player:getCharVar("ChasingQuotas_Progress")

    -- Rock Racketeer
    if (RockRacketeer == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.SHARP_GRAY_STONE)) then
        player:startEvent(261)

    elseif (Quotas_Status == 3) then
        player:startEvent(264) -- Someone was just asking about that earring.
    elseif (Quotas_Status == 4) then
        player:startEvent(265) -- They'll be happy if you return it.
    -- Standard dialog
    else
        player:startEvent(260)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    -- Rock Racketeer
    if (csid == 261 and option ~= 1) then
        player:delKeyItem(tpz.ki.SHARP_GRAY_STONE)
        player:addGil(GIL_RATE*10)
        player:setCharVar("rockracketeer_sold", 1)
    elseif (csid == 261 and option ~= 2) then
        player:setCharVar("rockracketeer_sold", 2)

    elseif (csid == 264) then
        player:setCharVar("ChasingQuotas_Progress", 4)
    end

end
