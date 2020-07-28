-----------------------------------
-- Area: Port Bastok
--  NPC: Otto
-- Standard Info NPC
-- Involved in Quest: The Siren's Tear
-- !pos -145.929 -7.48 -13.701 236
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local SirensTear = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_SIREN_S_TEAR)

    if (SirensTear == QUEST_ACCEPTED and player:getCharVar("SirensTear") == 0) then
        player:startEvent(5)
    else
        player:startEvent(20)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
