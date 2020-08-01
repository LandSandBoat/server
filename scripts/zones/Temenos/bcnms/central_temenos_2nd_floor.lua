-----------------------------------
-- Area: Temenos
-- Name: Central Temenos 2nd Floor
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Temenos/IDs")

function onBattlefieldInitialise(battlefield)
    battlefield:setLocalVar("loot", 1)
    SetServerVariable("[Central_Temenos_2nd_Floor]Time", battlefield:getTimeLimit()/60)
    tpz.limbus.handleDoors(battlefield)
    tpz.limbus.setupArmouryCrates(battlefield:getID())
end

function onBattlefieldTick(battlefield, tick)
    if battlefield:getRemainingTime() % 60 == 0 then
        SetServerVariable("[Central_Temenos_2nd_Floor]Time", battlefield:getRemainingTime()/60)
    end
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldEnter(player, battlefield)
    player:delKeyItem(tpz.ki.COSMOCLEANSE)
    player:delKeyItem(tpz.ki.WHITE_CARD)
    player:setCharVar("Cosmo_Cleanse_TIME", os.time())
end

function onBattlefieldDestroy(battlefield)
    tpz.limbus.handleDoors(battlefield, true)
    SetServerVariable("[Central_Temenos_2nd_Floor]Time", 0)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end