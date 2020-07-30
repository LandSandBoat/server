-----------------------------------
-- Area: Temenos
-- Name: Central Temenos 3rd Floor
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")

-- After registering the BCNM via bcnmRegister(bcnmid)
function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end


function onBattlefieldRegister(player, battlefield)
    SetServerVariable("[C_Temenos_3rd]UniqueID", os.time())
    HideArmouryCrates(Central_Temenos_3rd_Floor, TEMENOS)
    HideTemenosDoor(Central_Temenos_3rd_Floor)
end

-- Physically entering the BCNM via bcnmEnter(bcnmid)
function onBattlefieldEnter(player, battlefield)
    player:setCharVar("characterLimbusKey", GetServerVariable("[C_Temenos_3rd]UniqueID"))
    player:delKeyItem(tpz.ki.COSMOCLEANSE)
    player:delKeyItem(tpz.ki.WHITE_CARD)
end

-- Leaving  by every mean possible, given by the LeaveCode
-- 3=Disconnected or warped out (if dyna is empty: launch 4 after 3)
-- 4=Finish he dynamis

function onBattlefieldLeave(player, battlefield, leavecode)
    --print("leave code "..leavecode)
    if leavecode == tpz.battlefield.leaveCode.LOST then
        SetServerVariable("[C_Temenos_3rd]UniqueID", 0)
        player:setPos(580, -1.5, 4.452, 192)
    end
end
