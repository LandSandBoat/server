-----------------------------------
-- Area: Sealion's Den
-- Name: One to be Feared
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar("phaseChange", 1) -- Prevent battlefield from being completed until we want to.
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getCurrentMission(xi.mission.log_id.COP) ~= xi.mission.id.cop.ONE_TO_BE_FEARED or player:getCharVar("Mission[6][638]") ~= 3) and 1 or 0

        player:setLocalVar('battlefieldWin', battlefield:getID())

        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option)
end

battlefieldObject.onEventFinish = function(player, csid, option)
    -- NOTE: On completion, all members are sent back to Sealion's Den.
    -- If you're eligible for the cutscene when you zone in, you'll be sent to Lufaise directly afterwards.
    if csid == 32001 then
        player:addExp(1500)
    end
end

return battlefieldObject
