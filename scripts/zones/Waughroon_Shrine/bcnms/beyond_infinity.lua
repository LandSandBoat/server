-----------------------------------
-- Beyond Infinity
-- Wauhroon Shrine Level Break
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
    if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY) == QUEST_ACCEPTED then
        player:delKeyItem(xi.ki.SOUL_GEM_CLASP)
    end
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar('[cs]bit'), 0)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option, npc)
end

battlefieldObject.onEventFinish = function(player, csid, option, npc)
    if csid == 32001 then
        if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY) == QUEST_ACCEPTED then
            npcUtil.giveItem(player, xi.item.SCROLL_OF_INSTANT_WARP) -- scroll_of_instant_warp
            player:setCharVar('Quest[3][137]Prog', 1)
        end
    end
end

return battlefieldObject
