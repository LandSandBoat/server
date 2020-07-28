-----------------------------------
-- Area: Temenos
-- Name: Central Temenos 4th Floor
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")

-- After registering the BCNM via bcnmRegister(bcnmid)
function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end


function onBattlefieldRegister(player, battlefield)
    SetServerVariable("[C_Temenos_4th]UniqueID", os.time())
    HideArmouryCrates(Central_Temenos_4th_Floor, TEMENOS)
    HideTemenosDoor(Central_Temenos_4th_Floor)
    for n=16928986, 16928988, 1 do
        if (GetMobByID(n):isSpawned()) then DespawnMob(n); end
    end
    for n=16928991, 16929003, 1 do
        if (GetMobByID(n):isSpawned()) then DespawnMob(n); end
    end
    SpawnCofferTemenosCFloor4()
end

-- Physically entering the BCNM via bcnmEnter(bcnmid)
function onBattlefieldEnter(player, battlefield)
    player:setCharVar("characterLimbusKey", GetServerVariable("[C_Temenos_4th]UniqueID"))
    player:delKeyItem(tpz.ki.COSMOCLEANSE)
    player:delKeyItem(tpz.ki.WHITE_CARD)
end

-- Leaving  by every mean possible, given by the LeaveCode
-- 3=Disconnected or warped out (if dyna is empty: launch 4 after 3)
-- 4=Finish he dynamis

function onBattlefieldLeave(player, battlefield, leavecode)
    --print("leave code "..leavecode)
    if leavecode == tpz.battlefield.leaveCode.LOST then
        SetServerVariable("[C_Temenos_4th]UniqueID", 0)
        player:setPos(580, -1.5, 4.452, 192)
    end
end
