-----------------------------------
-- Area: Temenos
-- Name:
require("scripts/globals/battlefield")
-----------------------------------



function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

-- After registering the BCNM via bcnmRegister(bcnmid)
function onBattlefieldRegister(player, battlefield)
end

-- Physically entering the BCNM via bcnmEnter(bcnmid)
function onBattlefieldEnter(player, battlefield)
end

-- Leaving the Dynamis by every mean possible, given by the LeaveCode
-- 3=Disconnected or warped out (if dyna is empty: launch 4 after 3)
-- 4=Finish he dynamis

function onBattlefieldLeave(player, battlefield, leavecode)
--print("leave code "..leavecode)

    if leavecode == tpz.battlefield.leaveCode.WON then

        local name, clearTime, partySize = battlefield:getRecord()
     --    player:setPos(0, 0, 0, 0, 0x00)
    end
    if leavecode == tpz.battlefield.leaveCode.LOST then
        --SetServerVariable("[]UniqueID", 0)
    end

end
