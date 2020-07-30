-----------------------------------
-- Area: The_Eldieme_Necropolis_[S]
--  NPC: Heptachiond
-- Starts and Finishes Quest: REQUIEM_FOR_THE_DEPARTED
-- !pos 256 -32 20 175
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local Rftd = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.REQUIEM_FOR_THE_DEPARTED)

    -- Change to BRASS_RIBBON_OF_SERVICE later when Campaign has been added.
    if Rftd == QUEST_AVAILABLE and player:hasKeyItem(tpz.ki.BRONZE_RIBBON_OF_SERVICE) and player:getMainLvl() >= 30 then
        player:startEvent(105) -- Start quest "Requiem for the Departed"
    elseif Rftd == QUEST_ACCEPTED then
        if player:hasKeyItem(tpz.ki.SHEAF_OF_HANDMADE_INCENSE) then
            player:startEvent(107) -- During quest "Requiem for the Departed" (with Handmade Incense KI)
        else
            player:startEvent(106) -- During quest "Requiem for the Departed" (before retrieving KI Handmade Incense)
        end
    elseif Rftd == QUEST_COMPLETED then
        player:startEvent(108) -- New standard dialog after "Requiem for the Departed"
    else
        player:startEvent(104) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 105 then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.REQUIEM_FOR_THE_DEPARTED)
    elseif csid == 107 and npcUtil.completeQuest(player, CRYSTAL_WAR, tpz.quest.id.crystalWar.REQUIEM_FOR_THE_DEPARTED, {item = 4689}) then
        player:delKeyItem(tpz.ki.SHEAF_OF_HANDMADE_INCENSE)
    end
end
