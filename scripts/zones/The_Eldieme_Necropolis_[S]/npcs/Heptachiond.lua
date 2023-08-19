-----------------------------------
-- Area: The_Eldieme_Necropolis_[S]
--  NPC: Heptachiond
-- Starts and Finishes Quest: REQUIEM_FOR_THE_DEPARTED
-- !pos 256 -32 20 175
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local rftd = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.REQUIEM_FOR_THE_DEPARTED)

    -- Change to BRASS_RIBBON_OF_SERVICE later when Campaign has been added.
    if
        rftd == QUEST_AVAILABLE and
        player:hasKeyItem(xi.ki.BRONZE_RIBBON_OF_SERVICE) and
        player:getMainLvl() >= 30
    then
        player:startEvent(105) -- Start quest "Requiem for the Departed"
    elseif rftd == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.SHEAF_OF_HANDMADE_INCENSE) then
            player:startEvent(107) -- During quest "Requiem for the Departed" (with Handmade Incense KI)
        else
            player:startEvent(106) -- During quest "Requiem for the Departed" (before retrieving KI Handmade Incense)
        end
    elseif rftd == QUEST_COMPLETED then
        player:startEvent(108) -- New standard dialog after "Requiem for the Departed"
    else
        player:startEvent(104) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 105 then
        player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.REQUIEM_FOR_THE_DEPARTED)
    elseif
        csid == 107 and
        npcUtil.completeQuest(player, xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.REQUIEM_FOR_THE_DEPARTED, { item = 4689 })
    then
        player:delKeyItem(xi.ki.SHEAF_OF_HANDMADE_INCENSE)
    end
end

return entity
