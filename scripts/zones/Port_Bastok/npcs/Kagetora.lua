-----------------------------------
-- Area: Port Bastok
--  NPC: Kagetora
-- Involved in Quest: Ayame and Kaede, 20 in Pirate Years
-- !pos -96 -2 29 236
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.AYAME_AND_KAEDE) == QUEST_ACCEPTED) then

        local AyameAndKaede = player:getCharVar("AyameAndKaede_Event")

        if (AyameAndKaede == 0) then
            player:startEvent(241)
        elseif (AyameAndKaede > 2) then
            player:startEvent(244)
        else
            player:startEvent(23)
        end
    elseif (player:getCharVar("twentyInPirateYearsCS") == 1) then
        player:startEvent(261)
    elseif (player:getCharVar("FadedPromises") == 2 and player:hasKeyItem(tpz.ki.DIARY_OF_MUKUNDA)) then
        player:startEvent(296)
    else
        player:startEvent(23)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 241) then
        player:setCharVar("AyameAndKaede_Event", 1)
    elseif (csid == 261) then
        player:setCharVar("twentyInPirateYearsCS", 2)
    elseif (csid == 296) then
        player:setCharVar("FadedPromises", 3)
    end

end
