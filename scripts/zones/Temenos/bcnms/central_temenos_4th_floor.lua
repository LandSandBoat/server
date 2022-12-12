-----------------------------------
-- Area: Temenos
-- Name: Central Temenos 4th Floor
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Temenos/IDs")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar("loot", 1)
    SetServerVariable("[CENTRAL_TEMENOS_4TH_FLOOR]Time", battlefield:getTimeLimit() / 60)
    xi.limbus.handleDoors(battlefield)
    xi.limbus.setupArmouryCrates(battlefield:getID())
end

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    if battlefield:getRemainingTime() % 60 == 0 then
        SetServerVariable("[CENTRAL_TEMENOS_4TH_FLOOR]Time", battlefield:getRemainingTime() / 60)
    end

    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
    player:delKeyItem(xi.ki.COSMO_CLEANSE)
    player:delKeyItem(xi.ki.WHITE_CARD)
    player:setCharVar("Cosmo_Cleanse_TIME", os.time())
end

battlefieldObject.onBattlefieldDestroy = function(battlefield)
    xi.limbus.handleDoors(battlefield, true)
    SetServerVariable("[CENTRAL_TEMENOS_4TH_FLOOR]Time", 0)
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

return battlefieldObject
