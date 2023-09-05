-----------------------------------
-- Area: Monarch Linn
-- Name: Uninvited Guests
-----------------------------------
local ID = require("scripts/zones/Monarch_Linn/IDs")
require("scripts/globals/battlefield")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
    player:messageSpecial(ID.text.KI_TORN, xi.ki.MONARCH_LINN_PATROL_PERMIT)
    player:delKeyItem(xi.ki.MONARCH_LINN_PATROL_PERMIT)
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then -- play end CS. Need time and battle id for record keeping + storage
        local _, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    elseif
        leavecode == xi.battlefield.leaveCode.EXIT or
        leavecode == xi.battlefield.leaveCode.WARPDC
    then
        -- However the player got out of the BCNM - they didnt win
        player:setCharVar("UninvitedGuestsStatus", 3) -- update to failure state
    end
end

battlefieldObject.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        -- Victory
        player:setCharVar("UninvitedGuestsStatus", 2) -- update to victory state
    elseif csid == 32002 then
        -- Failure
        player:setCharVar("UninvitedGuestsStatus", 3) -- update to failure state
    end
end

return battlefieldObject
