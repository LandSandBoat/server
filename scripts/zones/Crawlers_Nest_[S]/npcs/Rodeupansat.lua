-----------------------------------
-- Area: Crawlers_Nest_[S]
--  NPC: Rodeupansat
-- Starts and Finishes Quest: EVIL_AT_THE_INLET
-- !pos 129 -34 26 171
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local evilAtTheInlet = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.EVIL_AT_THE_INLET)

    -- Change to BRASS_RIBBON_OF_SERVICE later when Campaign has been added.
    if
        evilAtTheInlet == QUEST_AVAILABLE and
        player:hasKeyItem(xi.ki.BRONZE_RIBBON_OF_SERVICE) and
        player:getMainLvl() >= 30
    then
        player:startEvent(107) -- Start quest "Evil at the Inlet"
    elseif evilAtTheInlet == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.EVIL_WARDING_SEAL) then
            player:startEvent(108) -- During quest after receiving KI and before losing KI
        else
            player:startEvent(109) -- After losing KI and returning for reward
        end
    elseif evilAtTheInlet == QUEST_COMPLETED then
        player:startEvent(110) -- New standard dialog after "Evil at the Inlet"
    else
        player:startEvent(106) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 107 then
        player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.EVIL_AT_THE_INLET)
        npcUtil.giveKeyItem(player, xi.ki.EVIL_WARDING_SEAL)
    elseif csid == 109 then
        npcUtil.completeQuest(player, xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.EVIL_AT_THE_INLET, { item = 4687 })
    end
end

return entity
