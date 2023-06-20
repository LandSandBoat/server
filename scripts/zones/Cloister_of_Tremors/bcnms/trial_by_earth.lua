-----------------------------------
-- Area: Cloister of Tremors
-- BCNM: Trial by Earth
-----------------------------------
local ID = require("scripts/zones/Cloister_of_Tremors/IDs")
require("scripts/globals/battlefield")
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
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRIAL_BY_EARTH)) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option)
end

battlefieldObject.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        player:delKeyItem(xi.ki.TUNING_FORK_OF_EARTH)
        player:addKeyItem(xi.ki.WHISPER_OF_TREMORS)
        player:addTitle(xi.title.HEIR_OF_THE_GREAT_EARTH)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WHISPER_OF_TREMORS)
    end
end

return battlefieldObject
