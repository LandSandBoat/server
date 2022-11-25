-----------------------------------
-- Area: Chamber of Oracles
-- Name: Shattering stars - Maat Fight
-- !pos -221 -24 19 206
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/items")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
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
        local pjob = player:getMainJob()
        local maatsCap = player:getCharVar("maatsCap")

        if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS) == QUEST_ACCEPTED then
            npcUtil.giveItem(player, xi.items.SCROLL_OF_INSTANT_WARP)
            player:setCharVar("Quest[3][132]Prog", pjob)
        end

        if not utils.mask.getBit(maatsCap, pjob - 1) then
            player:setCharVar("maatsCap", utils.mask.setBit(maatsCap, pjob - 1, true))
        end

        player:addTitle(xi.title.MAAT_MASHER)
    end
end

return battlefieldObject
