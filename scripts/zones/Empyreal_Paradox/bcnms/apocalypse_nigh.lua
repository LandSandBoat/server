-----------------------------------
-- Area: Empyreal_Paradox
-- Name: Apocalypse Nigh
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/common")
require("scripts/globals/quests")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.APOCALYPSE_NIGH) == QUEST_ACCEPTED and player:getCharVar('ApocalypseNigh') == 4 then
            player:setCharVar('ApocalypseNigh', 5)
            player:setCharVar("Apoc_Nigh_Reward",getMidnight())
            player:startEvent(7)
        end
    elseif csid == 7 then
        player:setPos(-.0745,-10,-465.1132,63,33)
    end
end