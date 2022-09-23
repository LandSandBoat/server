-----------------------------------
-- Area: Bastok Mines
--  NPC: Elki
-- Starts Quests: Hearts of Mythril, The Eleventh's Hour
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local hearts    = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.HEARTS_OF_MYTHRIL)
    local elevenths = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_ELEVENTH_S_HOUR)

    -- Hearts of Mythril
    if hearts == QUEST_AVAILABLE then
        player:startEvent(41)

    elseif
        hearts == QUEST_ACCEPTED and
        player:getCharVar("HeartsOfMythril") == 1
    then
        player:startEvent(42)

    -- The eleventh's hour
    elseif
        hearts == QUEST_COMPLETED and
        elevenths == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.BASTOK) >=2 and
        player:needToZone() == false
    then
        player:startEvent(43)

    elseif
        elevenths == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.OLD_TOOLBOX)
    then
        player:startEvent(44)

    -- Default
    else
        player:startEvent(31)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 41 and option == 0 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.HEARTS_OF_MYTHRIL)
        player:addKeyItem(xi.ki.BOUQUET_FOR_THE_PIONEERS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BOUQUET_FOR_THE_PIONEERS)
    elseif csid == 42 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12840)
        else
            player:addTitle(xi.title.PURSUER_OF_THE_PAST)
            player:addItem(12840)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12840)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.HEARTS_OF_MYTHRIL)
            player:addFame(xi.quest.fame_area.BASTOK, 80)
            player:setCharVar("HeartsOfMythril", 0)
            player:needToZone(true)
        end
    elseif csid == 43 and option == 1 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_ELEVENTH_S_HOUR)
    elseif csid == 44 then
        player:setCharVar("EleventhsHour", 1)
    end
end

return entity
