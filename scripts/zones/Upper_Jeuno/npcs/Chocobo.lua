-----------------------------------
-- Area: Upper Jeuno
--  NPC: Chocobo
-- Finishes Quest: Chocobo's Wounds
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    local ChocobosWounds = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.CHOCOBO_S_WOUNDS)

    if (ChocobosWounds == 0) then
        player:startEvent(62)
    elseif (ChocobosWounds == 1) then
        local count = trade:getItemCount()
        local gil = trade:getGil()

        if (trade:hasItemQty(4545, 1)) then
            player:startEvent(76)
        elseif (trade:hasItemQty(534, 1) and gil == 0 and count == 1) then
            --Check feeding status.
            local feed = player:getCharVar("ChocobosWounds_Event")
            local feedMin = player:getCharVar("ChocobosWounds_Min")
            local feedReady = (feedMin <= os.time())

            if (feed == 1) then
                player:startEvent(57)
            elseif (feedReady == true) then
                if (feed == 2) then
                    player:startEvent(58)
                elseif (feed == 3) then
                    player:startEvent(59)
                elseif (feed == 4) then
                    player:startEvent(60)
                elseif (feed == 5) then
                    player:startEvent(63)
                elseif (feed == 6) then
                    player:startEvent(64)
                end
            else
                if (feed > 2) then
                    player:startEvent(73)
                end
            end
        end
    else
        if (trade:hasItemQty(4545, 1)) then
            player:startEvent(38)
        end
    end
end

function onTrigger(player, npc)

    local ChocobosWounds = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.CHOCOBO_S_WOUNDS)

    if (ChocobosWounds == QUEST_COMPLETED and player:hasKeyItem(tpz.ki.CHOCOBO_LICENSE) == false) then
        -- this is a quick hack to let people get their license if it was lost
        player:addKeyItem(tpz.ki.CHOCOBO_LICENSE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CHOCOBO_LICENSE)
    elseif (ChocobosWounds == QUEST_AVAILABLE) then
        player:startEvent(62)
    elseif (ChocobosWounds == QUEST_ACCEPTED) then
        local feed = player:getCharVar("ChocobosWounds_Event")

        if (feed == 1) then
            player:startEvent(103)
        elseif (feed == 2) then
            player:startEvent(51)
        elseif (feed == 3) then
            player:startEvent(52)
        elseif (feed == 4) then
            player:startEvent(61)
        elseif (feed == 5) then
            player:startEvent(46)
        elseif (feed == 6) then
            player:startEvent(55)
        end
    elseif (ChocobosWounds == 2) then
        player:startEvent(55)
    else
        player:startEvent(54)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 57) then
        player:setCharVar("ChocobosWounds_Event", 2)
        player:setCharVar("ChocobosWounds_Min", os.time() + 60)
    elseif (csid == 58) then
        player:setCharVar("ChocobosWounds_Event", 3)
        player:setCharVar("ChocobosWounds_Min", os.time() + 60)
    elseif (csid == 59) then
        player:setCharVar("ChocobosWounds_Event", 4)
        player:setCharVar("ChocobosWounds_Min", os.time() + 60)
        player:tradeComplete()
        player:startEvent(99)
    elseif (csid == 60) then
        player:setCharVar("ChocobosWounds_Event", 5)
        player:setCharVar("ChocobosWounds_Min", os.time() + 60)
        player:tradeComplete()
    elseif (csid == 63) then
        player:setCharVar("ChocobosWounds_Event", 6)
        player:setCharVar("ChocobosWounds_Min", os.time() + 60)
        player:tradeComplete()
    elseif (csid == 64) then
        player:addKeyItem(tpz.ki.CHOCOBO_LICENSE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CHOCOBO_LICENSE)
        player:addTitle(tpz.title.CHOCOBO_TRAINER)
        player:setCharVar("ChocobosWounds_Event", 0)
        player:setCharVar("ChocobosWounds_Min", 0)
        player:addFame(JEUNO, 30)
        player:tradeComplete()
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.CHOCOBO_S_WOUNDS)
    end
end
