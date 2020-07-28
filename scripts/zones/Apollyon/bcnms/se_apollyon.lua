-----------------------------------
-- Area: Appolyon
-- Name: SE Apollyon
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")

-- After registering the BCNM via bcnmRegister(bcnmid)
function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end


function onBattlefieldRegister(player, battlefield)
    SetServerVariable("[SE_Apollyon]UniqueID", os.time())
    HideArmouryCrates(SE_Apollyon, APOLLYON_SE_NE)
end

-- Physically entering the BCNM via bcnmEnter(bcnmid)
function onBattlefieldEnter(player, battlefield)
    player:setCharVar("characterLimbusKey", GetServerVariable("[SE_Apollyon]UniqueID"))
    player:delKeyItem(tpz.ki.COSMOCLEANSE)
    player:delKeyItem(tpz.ki.BLACK_CARD)
end
-- 3=Disconnected or warped out (if dyna is empty: launch 4 after 3)
-- 4=Finish

function onBattlefieldLeave(player, battlefield, leavecode)
    -- print("leave code "..leavecode)
    if leavecode == tpz.battlefield.leaveCode.LOST then
        SetServerVariable("[SE_Apollyon]UniqueID", 0)
        player:setPos(643, 0.1, -600)
    end
end
