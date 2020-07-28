-----------------------------------
-- Area: Temenos
-- Name: Central Temenos 2nd Floor
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")

-- After registering the BCNM via bcnmRegister(bcnmid)
function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end


function onBattlefieldRegister(player, battlefield)
    if (GetMobByID(16929039):isSpawned()) then DespawnMob(16929039); end
    if (GetMobByID(16929040):isSpawned()) then DespawnMob(16929040); end
    if (GetMobByID(16929041):isSpawned()) then DespawnMob(16929041); end
    if (GetMobByID(16929042):isSpawned()) then DespawnMob(16929042); end
    if (GetMobByID(16929043):isSpawned()) then DespawnMob(16929043); end
    if (GetMobByID(16929044):isSpawned()) then DespawnMob(16929044); end
    SetServerVariable("[C_Temenos_2nd]UniqueID", os.time())
    HideArmouryCrates(Central_Temenos_2nd_Floor, TEMENOS)
    HideTemenosDoor(Central_Temenos_2nd_Floor)
end

-- Physically entering the BCNM via bcnmEnter(bcnmid)
function onBattlefieldEnter(player, battlefield)
    player:setCharVar("characterLimbusKey", GetServerVariable("[C_Temenos_2nd]UniqueID"))
    player:delKeyItem(tpz.ki.COSMOCLEANSE)
    player:delKeyItem(tpz.ki.WHITE_CARD)
end

-- Leaving by every mean possible, given by the LeaveCode
-- 3=Disconnected or warped out (if dyna is empty: launch 4 after 3)
-- 4=Finish he dynamis

function onBattlefieldLeave(player, battlefield, leavecode)
    --print("leave code "..leavecode)
    if leavecode == tpz.battlefield.leaveCode.LOST then
        SetServerVariable("[C_Temenos_2nd]UniqueID", 0)
        player:setPos(580, -1.5, 4.452, 192)
    end
end
