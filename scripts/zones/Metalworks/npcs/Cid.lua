-----------------------------------
-- Area: Metalworks
--  NPC: Cid
-- Starts & Finishes Quest: The Usual, Dark Puppet (start), Shoot First, Ask Questions Later
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
    local copMission = player:getCurrentMission(xi.mission.log_id.COP)
    local copStatus = player:getCharVar("PromathiaStatus")

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
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 897 then
        player:setCharVar("COP_tenzen_story", 1)
    elseif csid == 760 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_PUPPET)
        player:setCharVar("darkPuppetCS", 1)
    end
end

return entity
