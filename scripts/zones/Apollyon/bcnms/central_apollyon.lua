-----------------------------------
-- Area: Apollyon
-- Name: Central Apollyon
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
require("scripts/globals/limbus")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar("loot", 1)
    battlefield:setLocalVar("podReady", 1)
    SetServerVariable("[Central_Apollyon]Time", battlefield:getTimeLimit() / 60)
    xi.limbus.setupArmouryCrates(battlefield:getID())
end

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    if battlefield:getRemainingTime() % 60 == 0 then
        SetServerVariable("[Central_Apollyon]Time", battlefield:getRemainingTime() / 60)
    end

    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
    player:delKeyItem(xi.ki.COSMO_CLEANSE)
    player:setCharVar("Cosmo_Cleanse_TIME", os.time())

    if player:getCharVar("ApollyonEntrance") == 0 then
        player:delKeyItem(xi.ki.BLACK_CARD)
    else
        player:delKeyItem(xi.ki.RED_CARD)
    end
end

battlefieldObject.onBattlefieldDestroy = function(battlefield)
    SetServerVariable("[Central_Apollyon]Time", 0)
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    player:messageSpecial(ID.text.HUM + 1)

    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

return battlefieldObject
