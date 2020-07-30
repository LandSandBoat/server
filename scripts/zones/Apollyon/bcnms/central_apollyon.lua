-----------------------------------
-- Area: Appolyon
-- Name: Central Apollyon
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")

-- After registering the BCNM via bcnmRegister(bcnmid)
function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end


function onBattlefieldRegister(player, battlefield)
    SetServerVariable("[Central_Apollyon]UniqueID", os.time())
    HideArmouryCrates(Central_Apollyon, APOLLYON_SE_NE)
    GetNPCByID(16933248):setAnimation(8)
    if (GetMobByID():isSpawned(16933125)) then DespawnMob(16933125); end
end

-- Physically entering the BCNM via bcnmEnter(bcnmid)
function onBattlefieldEnter(player, battlefield)
    player:setCharVar("characterLimbusKey", GetServerVariable("[Central_Apollyon]UniqueID"))
    player:delKeyItem(tpz.ki.COSMOCLEANSE)
end

-- Leaving  by every mean possible, given by the LeaveCode
-- 3=Disconnected or warped out (if dyna is empty: launch 4 after 3)
-- 4=Finish

function onBattlefieldLeave(player, battlefield, leavecode)
    --print("leave code "..leavecode)
    if leavecode == tpz.battlefield.leaveCode.LOST then
        SetServerVariable("[Central_Apollyon]UniqueID", 0)
        player:setPos(-668, 0.1, -666)
    end
end
