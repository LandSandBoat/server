-----------------------------------
-- Tango with a Tracker
-- Boneyard Gully Quest Battlefield, KI: Letter from Shikaree X
-- !addkeyitem LETTER_FROM_SHIKAREE_X
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require('scripts/globals/quests')
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldInitialise = function(battlefield)
end

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
    if player:hasKeyItem(xi.ki.LETTER_FROM_SHIKAREE_X) then
        player:delKeyItem(xi.ki.LETTER_FROM_SHIKAREE_X)
    end
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
        player:addGil(10000)
        player:addTitle(xi.title.SIN_HUNTER_HUNTER)
        player:completeQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.TANGO_WITH_A_TRACKER)
    end
end

return battlefield_object
