-----------------------------------
-- Area: Selbina
--  NPC: Thunder Hawk
-- Starts and Finishes Quest: The Rescue
-- !pos -58 -10 6 248
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/titles")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local theRescue = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_RESCUE)
    local fame = math.floor((player:getFameLevel(SANDORIA) + player:getFameLevel(BASTOK)) / 2) -- Selbina Fame

    if theRescue == QUEST_AVAILABLE and fame >= 1 then
        player:startEvent(80) -- Start quest "The rescue"
    elseif theRescue == QUEST_ACCEPTED and not player:hasKeyItem(xi.ki.TRADERS_SACK) then
        player:startEvent(83) -- During quest "The rescue"
    elseif theRescue == QUEST_ACCEPTED then
        player:startEvent(81) -- Finish quest "The rescue"
    elseif theRescue == QUEST_COMPLETED then
        player:startEvent(82) -- New standard dialog
    else
        player:startEvent(84) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 80 and option == 70 then
        player:addQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_RESCUE)
    elseif csid == 81 and npcUtil.completeQuest(player, OTHER_AREAS_LOG, xi.quest.id.otherAreas.THE_RESCUE, {fame_area = SELBINA, ki = xi.ki.MAP_OF_THE_RANGUEMONT_PASS, title = xi.title.HONORARY_CITIZEN_OF_SELBINA, gil = 3000}) then
        player:delKeyItem(xi.ki.TRADERS_SACK)
    end
end

return entity
