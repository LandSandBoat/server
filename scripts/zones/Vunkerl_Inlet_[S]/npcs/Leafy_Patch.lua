-----------------------------------
-- Area: Vunkerl Inlet (S) (F-5)
--  NPC: Leafy Patch
-- Involved in Quests
-- !pos -418 -33 576
-----------------------------------
local ID = require("scripts/zones/Vunkerl_Inlet_[S]/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.BOY_AND_THE_BEAST) == QUEST_ACCEPTED and player:getCharVar("BoyAndTheBeast") == 2) then
        if (VanadielHour() < 8) then
            player:startEvent(107)
        elseif (VanadielHour() < 16) then
            player:startEvent(107, 1)
        else
            player:startEvent(107, 2)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 107) then
        if (option == 1) then
            player:addKeyItem(tpz.ki.VUNKERL_HERB)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.VUNKERL_HERB)
            player:setCharVar("BoyAndTheBeast", 3)
        else
            player:addKeyItem(tpz.ki.VUNKERL_HERB)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.VUNKERL_HERB)
            player:setCharVar("BoyAndTheBeast", 4)
        end
    end
end
