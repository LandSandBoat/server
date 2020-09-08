-----------------------------------
-- Area: Appolyon
-- Name:
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")


-- After registering the BCNM via bcnmRegister(bcnmid)
function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end


function onBattlefieldRegister(player, battlefield)
    SetServerVariable("[CS_Apollyon]UniqueID", os.time())
    HideArmouryCrates(CS_Apollyon, APOLLYON_SE_NE)
    SetServerVariable("[CS_Apollyon]Already_Received", 0)
    GetNPCByID(16933245):setAnimation(8)
    GetNPCByID(16933246):setAnimation(8)
    GetNPCByID(16933247):setAnimation(8)
    despawnLimbusCS()
end

-- Physically entering the BCNM via bcnmEnter(bcnmid)
function onBattlefieldEnter(player, battlefield)
    player:setCharVar("characterLimbusKey", GetServerVariable("[CS_Apollyon]UniqueID"))
    player:delKeyItem(tpz.ki.COSMOCLEANSE)
end

-- Leaving the by every mean possible, given by the LeaveCode
-- 3=Disconnected or warped out (if dyna is empty: launch 4 after 3)
-- 4=Finish
function onBattlefieldLeave(player, battlefield, leavecode)
    --print("leave code "..leavecode)
    if leavecode == tpz.battlefield.leaveCode.LOST then
        SetServerVariable("[CS_Apollyon]UniqueID", 0)
        player:setPos(-668, 0.1, -666)
    end
end
