-----------------------------------
-- Area: Cloister of Flames
-- BCNM: Trial by Fire
-----------------------------------
local ID = require("scripts/zones/Cloister_of_Flames/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
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
        local arg8 = (player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_FIRE)) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        player:delKeyItem(xi.ki.TUNING_FORK_OF_FIRE)
        player:addKeyItem(xi.ki.WHISPER_OF_FLAMES)
        player:addTitle(xi.title.HEIR_OF_THE_GREAT_FIRE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WHISPER_OF_FLAMES)
    end
end

return battlefield_object
