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

    -- The eleventh's hour
    if
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
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 43 and option == 1 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_ELEVENTH_S_HOUR)
    elseif csid == 44 then
        player:setCharVar("EleventhsHour", 1)
    end
end

return entity
