-----------------------------------
-- Area: Windurst Waters
--  NPC: Hariga-Origa
--  Starts & Finishes Quest: Glyph Hanger
-- Involved in Mission 2-1
-- !pos -62 -6 105 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/settings/main")
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
    local smudgeStatus = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.A_SMUDGE_ON_ONE_S_RECORD)
    local Fame = player:getFameLevel(WINDURST)

    if (smudgeStatus == QUEST_COMPLETED and player:needToZone() == true) then
        player:startEvent(418)
    elseif (smudgeStatus == QUEST_ACCEPTED) then
        player:startEvent(414, 0, 637, 4382)
    elseif (smudgeStatus == QUEST_AVAILABLE and player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CHASING_TALES) == QUEST_COMPLETED and Fame >= 4) then
        player:startEvent(413, 0, 637, 4382)

    else
        player:startEvent(372)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 413 and option == 0) then
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
