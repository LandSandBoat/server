-----------------------------------
-- Area: Metalworks
--  NPC: Cid
-- Starts & Finishes Quest: Cid's Secret, The Usual, Dark Puppet (start), Shoot First, Ask Questions Later
-- Involved in Mission: Bastok 7-1
-- !pos -12 -12 1 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local cidsSecret = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.CID_S_SECRET)
    local copMission = player:getCurrentMission(xi.mission.log_id.COP)
    local copStatus = player:getCharVar("PromathiaStatus")
    local hasLetter = player:hasKeyItem(xi.ki.UNFINISHED_LETTER)

    -- DAWN
    if
        copMission == xi.mission.id.cop.DAWN and
        copStatus == 3 and
        player:getCharVar("Promathia_kill_day") < os.time() and
        player:getCharVar("COP_tenzen_story") == 0
    then
        player:startEvent(897)

    -- DARK PUPPET
    elseif
        player:getMainJob() == xi.job.DRK and
        player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL and
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_LEGACY) == QUEST_COMPLETED and
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_PUPPET) == QUEST_AVAILABLE
    then
        player:startEvent(760)

    --Begin Cid's Secret
    elseif (player:getFameLevel(xi.quest.fame_area.BASTOK) >= 4 and cidsSecret == QUEST_AVAILABLE) then
        player:startEvent(507)
    elseif cidsSecret == QUEST_ACCEPTED and not hasLetter and player:getCharVar("CidsSecret_Event") == 1 then
        player:startEvent(508) -- After talking to Hilda, Cid gives information on the item she needs
    elseif cidsSecret == QUEST_ACCEPTED and not hasLetter then
        player:startEvent(502) -- Reminder dialogue from Cid if you have not spoken to Hilda
    elseif cidsSecret == QUEST_ACCEPTED and hasLetter then
        player:startEvent(509)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 897 then
        player:setCharVar("COP_tenzen_story", 1)
    elseif csid == 760 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_PUPPET)
        player:setCharVar("darkPuppetCS", 1)
    elseif (csid == 507) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.CID_S_SECRET)
    elseif (csid == 509) then
        if (player:getFreeSlotsCount(0) >= 1) then
            player:delKeyItem(xi.ki.UNFINISHED_LETTER)
            player:setCharVar("CidsSecret_Event", 0)
            player:addItem(13570)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13570) -- Ram Mantle
            player:addFame(xi.quest.fame_area.BASTOK, 30)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.CID_S_SECRET)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13570)
        end
    end
end

return entity
