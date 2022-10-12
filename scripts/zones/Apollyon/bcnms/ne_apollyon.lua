-----------------------------------
-- Area: Appolyon
-- Name: NE Apollyon
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
require("scripts/globals/limbus")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/utils")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldInitialise = function(battlefield)
    local floorOnekey, floorOnechest = unpack(utils.uniqueRandomTable(1, 3, 2))

    battlefield:setLocalVar("randomF1key", floorOnekey)     -- Set var to determine Floor 1 Key Mob.
    battlefield:setLocalVar("randomF1chest", floorOnechest) -- Set var to determine Floor 1 Chest Mob.
    battlefield:setLocalVar("loot", 1)
    SetServerVariable("[NE_Apollyon]Time", battlefield:getTimeLimit() / 60)
    xi.limbus.handleDoors(battlefield)
    xi.limbus.setupArmouryCrates(battlefield:getID())
end

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    if battlefield:getRemainingTime() % 60 == 0 then
        SetServerVariable("[NE_Apollyon]Time", battlefield:getRemainingTime() / 60)
    end

    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
    player:delKeyItem(xi.ki.COSMO_CLEANSE)
    player:delKeyItem(xi.ki.BLACK_CARD)
    player:setCharVar("Cosmo_Cleanse_TIME", os.time())
end

battlefieldObject.onBattlefieldDestroy = function(battlefield)
    xi.limbus.handleDoors(battlefield, true)
    SetServerVariable("[NE_Apollyon]Time", 0)
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    player:messageSpecial(ID.text.HUM + 1)

    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        player:startCutscene(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startCutscene(32002)
    end
end

return battlefieldObject
