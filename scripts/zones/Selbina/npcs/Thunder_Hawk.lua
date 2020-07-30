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

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local theRescue = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_RESCUE)
    local fame = math.floor((player:getFameLevel(SANDORIA) + player:getFameLevel(BASTOK)) / 2) -- Selbina Fame

    if theRescue == QUEST_AVAILABLE and fame >= 1 then
        player:startEvent(80) -- Start quest "The rescue"
    elseif theRescue == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.TRADERS_SACK) then
        player:startEvent(83) -- During quest "The rescue"
    elseif theRescue == QUEST_ACCEPTED then
        player:startEvent(81) -- Finish quest "The rescue"
    elseif theRescue == QUEST_COMPLETED then
        player:startEvent(82) -- New standard dialog
    else
        player:startEvent(84) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 80 and option == 70 then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_RESCUE)
    elseif csid == 81 and npcUtil.completeQuest(player, OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_RESCUE, {fame_area = SELBINA, ki = tpz.ki.MAP_OF_THE_RANGUEMONT_PASS, title = tpz.title.HONORARY_CITIZEN_OF_SELBINA, gil = 3000}) then
        player:delKeyItem(tpz.ki.TRADERS_SACK)
    end
end
