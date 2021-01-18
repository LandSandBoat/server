-----------------------------------
-- Area: Temenos
-- Name:
-----------------------------------
require("scripts/globals/battlefield")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

-- After registering the BCNM via bcnmRegister(bcnmid)
battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

-- Physically entering the BCNM via bcnmEnter(bcnmid)
battlefield_object.onBattlefieldEnter = function(player, battlefield)
end

-- Leaving by every mean possible, given by the LeaveCode
-- 3=Disconnected or warped out (if dyna is empty: launch 4 after 3)
-- 4=Finish he dynamis

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    -- print("leave code "..leavecode)

    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        -- player:setPos(0, 0, 0, 0, 0x00)
    end
    if leavecode == tpz.battlefield.leaveCode.LOST then
    end
end

return battlefield_object
