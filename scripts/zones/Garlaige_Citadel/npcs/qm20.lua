-----------------------------------
-- Area: Garlaige Citadel
--  NPC: qm20 (??? - Bomb Coal Fragments)
-- Involved in Quest: In Defiant Challenge
-- !pos -137.047 0 347.502 200
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (OldSchoolG1 == false) then
        if (player:hasItem(1090) == false and player:hasKeyItem(tpz.ki.BOMB_COAL_FRAGMENT3) == false
        and player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.IN_DEFIANT_CHALLENGE) == QUEST_ACCEPTED) then
            player:addKeyItem(tpz.ki.BOMB_COAL_FRAGMENT3)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BOMB_COAL_FRAGMENT3)
        end

        if (player:hasKeyItem(tpz.ki.BOMB_COAL_FRAGMENT1) and player:hasKeyItem(tpz.ki.BOMB_COAL_FRAGMENT2) and player:hasKeyItem(tpz.ki.BOMB_COAL_FRAGMENT3)) then
            if (player:getFreeSlotsCount() >= 1) then
                player:addItem(1090, 1)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 1090)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1090)
            end
        end

        if (player:hasItem(1090)) then
            player:delKeyItem(tpz.ki.BOMB_COAL_FRAGMENT1)
            player:delKeyItem(tpz.ki.BOMB_COAL_FRAGMENT2)
            player:delKeyItem(tpz.ki.BOMB_COAL_FRAGMENT3)
        end
    end
end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)
end
