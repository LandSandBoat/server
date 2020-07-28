-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Morjean
-- Involved in Quest: A Squire's Test II (Optional), The Holy Crest
-- !pos 99 0 116 231
-------------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local TheHolyCrest = player:getCharVar("TheHolyCrest_Event")

    if (TheHolyCrest == 2) then
        player:startEvent(65)
    elseif ((TheHolyCrest == 3 and player:hasItem(1159)) or TheHolyCrest == 4) then -- Wyvern Egg
        player:startEvent(62)
    elseif (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.A_SQUIRE_S_TEST_II) == QUEST_ACCEPTED) then
        player:startEvent(602)
    else
        player:startEvent(601)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 65) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.THE_HOLY_CREST)
        player:setCharVar("TheHolyCrest_Event", 3)
    elseif (csid == 62 and option == 0) then
        player:setCharVar("TheHolyCrest_Event", 4)
    end

end
