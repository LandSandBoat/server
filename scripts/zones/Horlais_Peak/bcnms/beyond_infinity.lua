-----------------------------------
-- Beyond Infinity
-- Horlais Peak Level Break
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/items")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
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
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option)
end

battlefieldObject.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY) == QUEST_ACCEPTED then
            npcUtil.giveItem(player, xi.items.SCROLL_OF_INSTANT_WARP) -- scroll_of_instant_warp
            player:setCharVar("Quest[3][137]Prog", 1)
        end
    end
end

return battlefieldObject
