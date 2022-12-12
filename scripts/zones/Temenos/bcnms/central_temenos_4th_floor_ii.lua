-----------------------------------
-- Area: Temenos
-- Name:
-----------------------------------
require("scripts/globals/battlefield")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

-- After registering the BCNM via bcnmRegister(bcnmid)
battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

-- Physically entering the BCNM via bcnmEnter(bcnmid)
battlefieldObject.onBattlefieldEnter = function(player, battlefield)
end

-- Leaving by every mean possible, given by the LeaveCode
-- 3=Disconnected or warped out (if dyna is empty: launch 4 after 3)
-- 4=Finish he dynamis

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        -- local name, clearTime, partySize = battlefield:getRecord()
        -- player:setPos(0, 0, 0, 0, 0x00)
    end

    if leavecode == xi.battlefield.leaveCode.LOST then
    end
end

return battlefieldObject
