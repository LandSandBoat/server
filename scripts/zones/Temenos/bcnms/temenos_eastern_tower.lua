-----------------------------------
-- Area: Temenos
-- Name: Temenos Eastern Tower
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")

-- After registering the BCNM via bcnmRegister(bcnmid)
function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end


function onBattlefieldRegister(player, battlefield)
    if (GetMobByID(16928844):isSpawned()) then DespawnMob(16928844); end
    if (GetMobByID(16928853):isSpawned()) then DespawnMob(16928853); end
    if (GetMobByID(16928862):isSpawned()) then DespawnMob(16928862); end
    if (GetMobByID(16928871):isSpawned()) then DespawnMob(16928871); end
    if (GetMobByID(16928880):isSpawned()) then DespawnMob(16928880); end
    if (GetMobByID(16928889):isSpawned()) then DespawnMob(16928889); end
    if (GetMobByID(16928894):isSpawned()) then DespawnMob(16928894); end
    SetServerVariable("[Temenos_E_Tower]UniqueID", os.time())
    HideArmouryCrates(Temenos_Eastern_Tower, TEMENOS)
    HideTemenosDoor(Temenos_Eastern_Tower)
end

-- Physically entering the BCNM via bcnmEnter(bcnmid)
function onBattlefieldEnter(player, battlefield)
    player:setCharVar("characterLimbusKey", GetServerVariable("[Temenos_E_Tower]UniqueID"))
    player:delKeyItem(tpz.ki.COSMOCLEANSE)
    player:delKeyItem(tpz.ki.WHITE_CARD)
end

-- Leaving the Dynamis by every mean possible, given by the LeaveCode
-- 3=Disconnected or warped out (if dyna is empty: launch 4 after 3)
-- 4=Finish he dynamis

function onBattlefieldLeave(player, battlefield, leavecode)
    --print("leave code "..leavecode)
    if leavecode == tpz.battlefield.leaveCode.LOST then
        SetServerVariable("[Temenos_E_Tower]UniqueID", 0)
        player:setPos(580, -1.5, 4.452, 192)
    end
end
