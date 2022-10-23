-----------------------------------
-- Area: Temenos
-- Name: Temenos Northern Tower
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Temenos/IDs")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar("loot", 1)
    battlefield:setLocalVar("randomF1", math.random(2, 5))
    SetServerVariable("[Temenos_Northern_Tower]Time", battlefield:getTimeLimit() / 60)
    xi.limbus.handleDoors(battlefield)
    xi.limbus.setupArmouryCrates(battlefield:getID())
    DespawnMob(ID.mob.TEMENOS_N_MOB[3] + 3)
    DespawnMob(ID.mob.TEMENOS_N_MOB[4] + 3)
    DespawnMob(ID.mob.TEMENOS_N_MOB[6] + 4)
    DespawnMob(ID.mob.TEMENOS_N_MOB[6] + 8)
    DespawnMob(ID.mob.TEMENOS_N_MOB[6] + 12)
end

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    if battlefield:getRemainingTime() % 60 == 0 then
        SetServerVariable("[Temenos_Northern_Tower]Time", battlefield:getRemainingTime() / 60)
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
    SetServerVariable("[Temenos_Northern_Tower]Time", 0)
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
