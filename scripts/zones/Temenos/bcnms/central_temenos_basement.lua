-----------------------------------
-- Area: Temenos
-- Name: Central Temenos Basement
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Temenos/IDs")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar("loot", 1)
    battlefield:setLocalVar("lootSpawned", 1)
    SetServerVariable("[Central_Temenos_Basement]Time", battlefield:getTimeLimit()/60)
    tpz.limbus.handleDoors(battlefield)
    tpz.limbus.setupArmouryCrates(battlefield:getID())
    DespawnMob(ID.mob.TEMENOS_C_MOB[5]+3)
    DespawnMob(ID.mob.TEMENOS_C_MOB[5]+6)
    DespawnMob(ID.mob.TEMENOS_C_MOB[5]+14)
    DespawnMob(ID.mob.TEMENOS_C_MOB[5]+17)
    DespawnMob(ID.mob.TEMENOS_C_MOB[5]+21)
    DespawnMob(ID.mob.TEMENOS_C_MOB[5]+27)
end

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    if battlefield:getRemainingTime() % 60 == 0 then
        SetServerVariable("[Central_Temenos_Basement]Time", battlefield:getRemainingTime()/60)
    end
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
    player:delKeyItem(tpz.ki.COSMOCLEANSE)
    player:delKeyItem(tpz.ki.WHITE_CARD)
    player:setCharVar("Cosmo_Cleanse_TIME", os.time())
end

battlefield_object.onBattlefieldDestroy = function(battlefield)
    tpz.limbus.handleDoors(battlefield, true)
    SetServerVariable("[Central_Temenos_Basement]Time", 0)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end
return battlefield_object
