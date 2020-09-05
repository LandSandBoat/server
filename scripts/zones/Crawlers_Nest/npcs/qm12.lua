-----------------------------------
-- Area: Crawlers' Nest
--  NPC: qm12 (??? - Exoray Mold Crumbs)
-- Involved in Quest: In Defiant Challenge
-- !pos 99.326 -0.126 -188.869 197
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
local ID = require("scripts/zones/Crawlers_Nest/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (OldSchoolG1 == false) then
        if (player:hasItem(1089) == false and player:hasKeyItem(tpz.ki.EXORAY_MOLD_CRUMB3) == false
        and player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.IN_DEFIANT_CHALLENGE) == QUEST_ACCEPTED) then
            player:addKeyItem(tpz.ki.EXORAY_MOLD_CRUMB3)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.EXORAY_MOLD_CRUMB3)
        end

        if (player:hasKeyItem(tpz.ki.EXORAY_MOLD_CRUMB1) and player:hasKeyItem(tpz.ki.EXORAY_MOLD_CRUMB2) and player:hasKeyItem(tpz.ki.EXORAY_MOLD_CRUMB3)) then
            if (player:getFreeSlotsCount() >= 1) then
                player:addItem(1089, 1)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 1089)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1089)
            end
        end

        if (player:hasItem(1089)) then
            player:delKeyItem(tpz.ki.EXORAY_MOLD_CRUMB1)
            player:delKeyItem(tpz.ki.EXORAY_MOLD_CRUMB2)
            player:delKeyItem(tpz.ki.EXORAY_MOLD_CRUMB3)
        end
    end
end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)
end
