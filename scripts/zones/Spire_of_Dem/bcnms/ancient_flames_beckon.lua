-----------------------------------
-- Ancient Flames Beckon
-- Spire of Dem mission battlefield
-----------------------------------
local ID = require("scripts/zones/Spire_of_Dem/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/teleports")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/status")
require('scripts/missions/cop/helpers')
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
        local arg8 = xi.cop.helpers.numPromyvionCompleted(player, xi.cop.helpers.promyvionCrags.DEM) + 1
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 0, battlefield:getLocalVar("[cs]bit"), 0, arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
end

return battlefield_object
