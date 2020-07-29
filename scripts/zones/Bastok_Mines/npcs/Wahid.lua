-----------------------------------
-- Area: Bastok Mines
--  NPC: Wahid
-- Start & Finishes Quest: The Siren's Tear
-- !pos 26.305 -1 -66.403 234
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/settings")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    local SirensTear = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_SIREN_S_TEAR)

    if (SirensTear ~= QUEST_AVAILABLE) then
        if (trade:hasItemQty(576, 1) and trade:getItemCount() == 1) then
            player:startEvent(82)
        end
    end
end

function onTrigger(player, npc)
    local SirensTear = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_SIREN_S_TEAR)

    if (SirensTear == QUEST_AVAILABLE) then
        player:startEvent(81)
    else
        player:startEvent(28)
    end
end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)

    if (csid == 81) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.THE_SIREN_S_TEAR)
    elseif (csid == 82) then
        player:tradeComplete()
        player:completeQuest(BASTOK, tpz.quest.id.bastok.THE_SIREN_S_TEAR)
        player:addFame(BASTOK, 120)
        player:addGil(150*GIL_RATE)
        player:messageSpecial(ID.text.GIL_OBTAINED, 150*GIL_RATE)
        player:addTitle(tpz.title.TEARJERKER)
        player:setCharVar("SirensTear", 0)
    end
end
