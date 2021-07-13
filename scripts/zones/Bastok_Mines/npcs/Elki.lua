-----------------------------------
-- Area: Bastok Mines
--  NPC: Elki
-- Starts Quests: Hearts of Mythril, The Eleventh's Hour
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/titles")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local Fame = player:getFameLevel(BASTOK)
    local Hearts = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.HEARTS_OF_MYTHRIL)
    local HeartsVar = player:getCharVar("HeartsOfMythril")
    local Elevenths = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_ELEVENTH_S_HOUR)
    local HasToolbox = player:hasKeyItem(xi.ki.OLD_TOOLBOX)

    if (Hearts == QUEST_AVAILABLE) then
        player:startEvent(41)
    elseif (Hearts == QUEST_ACCEPTED and HeartsVar == 1) then
        player:startEvent(42)
    elseif (Hearts == QUEST_COMPLETED and Elevenths == QUEST_AVAILABLE and Fame >=2 and player:needToZone() == false) then
        player:startEvent(43)
    elseif (Elevenths == QUEST_ACCEPTED and HasToolbox) then
        player:startEvent(44)
    else
        player:startEvent(31)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 41 and option == 0) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.HEARTS_OF_MYTHRIL)
        player:addKeyItem(xi.ki.BOUQUETS_FOR_THE_PIONEERS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BOUQUETS_FOR_THE_PIONEERS)
    elseif (csid == 42) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12840)
        else
            player:addTitle(xi.title.PURSUER_OF_THE_PAST)
            player:addItem(12840)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12840)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.HEARTS_OF_MYTHRIL)
            player:addFame(BASTOK, 80)
            player:setCharVar("HeartsOfMythril", 0)
            player:needToZone(true)
        end
    elseif (csid == 43 and option == 1) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_ELEVENTH_S_HOUR)
    elseif (csid == 44) then
        player:setCharVar("EleventhsHour", 1)
    end

end

return entity
