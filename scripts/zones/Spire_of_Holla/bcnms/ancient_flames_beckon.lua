-----------------------------------
-- Ancient Flames Beckon
-- Spire of Holla mission battlefield
-----------------------------------
local ID = require("scripts/zones/Spire_of_Holla/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/teleports")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require('scripts/missions/cop/helpers')
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
        local arg8 = xi.cop.helpers.numPromyvionCompleted(player, xi.cop.helpers.promyvionCrags.HOLLA) + 1
        local copMission = player:getCurrentMission(xi.mission.log_id.COP)
        local promyvionId = (player:getZoneID() - 17) / 2

        if
            (copMission == xi.mission.id.cop.BELOW_THE_ARKS or
            copMission == xi.mission.id.cop.THE_MOTHERCRYSTALS) and
            not player:hasKeyItem(xi.ki.LIGHT_OF_HOLLA + promyvionId)
        then
            player:setLocalVar('newPromy', 1)
        end

        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 0, battlefield:getLocalVar("[cs]bit"), 0, arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option)
end

battlefieldObject.onEventFinish = function(player, csid, option)
    if
        player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.THE_MOTHERCRYSTALS and
        not player:getLocalVar('toLufaise') == 1
    then
        player:addExp(1500)
        xi.teleport.to(player, xi.teleport.id.EXITPROMDEM)
    end
end

return battlefieldObject
