-----------------------------------
-- Area: Windurst Waters
--  NPC: Hariga-Origa
--  Starts & Finishes Quest: Glyph Hanger
-- Involved in Mission 2-1
-- !pos -62 -6 105 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local smudgeStatus = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.A_SMUDGE_ON_ONE_S_RECORD)

    if (smudgeStatus == QUEST_ACCEPTED and trade:hasItemQty(637, 1) and trade:hasItemQty(4382, 1)) then
        player:startEvent(417, 3000)
    end
end

entity.onTrigger = function(player, npc)
    local GlyphHanger = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.GLYPH_HANGER)
    local chasingStatus = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CHASING_TALES)
    local smudgeStatus = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.A_SMUDGE_ON_ONE_S_RECORD)
    local Fame = player:getFameLevel(WINDURST)

    if (smudgeStatus == QUEST_COMPLETED and player:needToZone() == true) then
        player:startEvent(418)
    elseif (smudgeStatus == QUEST_ACCEPTED) then
        player:startEvent(414, 0, 637, 4382)
    elseif (smudgeStatus == QUEST_AVAILABLE and chasingStatus == QUEST_COMPLETED and Fame >= 4) then
        player:startEvent(413, 0, 637, 4382)
    elseif (GlyphHanger == QUEST_COMPLETED and chasingStatus ~= QUEST_COMPLETED) then
        player:startEvent(386)
    elseif (GlyphHanger == QUEST_ACCEPTED) then
        if (player:hasKeyItem(xi.ki.NOTES_FROM_IPUPU)) then
            player:startEvent(385)
        else
            player:startEvent(382)
        end
    elseif (GlyphHanger == QUEST_AVAILABLE) then
        player:startEvent(381)

    else
        player:startEvent(372) -- The line will never be executed
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 381 and option == 0) then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.GLYPH_HANGER)
        player:addKeyItem(xi.ki.NOTES_FROM_HARIGAORIGA)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.NOTES_FROM_HARIGAORIGA)
    elseif (csid == 385) then
        player:needToZone(true)
        player:delKeyItem(xi.ki.NOTES_FROM_IPUPU)
        if (player:hasKeyItem(xi.ki.MAP_OF_THE_HORUTOTO_RUINS) == false) then
            player:addKeyItem(xi.ki.MAP_OF_THE_HORUTOTO_RUINS)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MAP_OF_THE_HORUTOTO_RUINS)
        end
        player:addFame(WINDURST, 120)
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.GLYPH_HANGER)
    elseif (csid == 413 and option == 0) then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.A_SMUDGE_ON_ONE_S_RECORD)
    elseif (csid == 417) then
        player:needToZone(true)
        player:addGil(xi.settings.GIL_RATE*3000)
        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.GIL_RATE*3000)
        if (player:hasKeyItem(xi.ki.MAP_OF_FEIYIN) == false) then
            player:addKeyItem(xi.ki.MAP_OF_FEIYIN)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MAP_OF_FEIYIN)
        end
        player:addFame(WINDURST, 120)
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.A_SMUDGE_ON_ONE_S_RECORD)
    end
end

return entity
