-----------------------------------
-- Area: Empyreal_Paradox
-- Name: Apocalypse Nigh
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/quests")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == QUEST_ACCEPTED and player:getCharVar('ApocalypseNigh') == 4 then
            player:setCharVar('ApocalypseNigh', 5)
            player:setCharVar("Apoc_Nigh_Reward",getMidnight())
            player:startEvent(7)
        end
    elseif csid == 7 then
        player:setPos(-.0745,-10,-465.1132,63,33)
    end
end

return battlefield_object
