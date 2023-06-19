-----------------------------------
-- Area: Empyreal_Paradox
-- Name: Dawn
-- instance 1 Promathia !pos -520 -119 524
-- instance 2 Promathia !pos 521 -0.500 517
-- instance 3 Promathia !pos -519 120 -520
-----------------------------------
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/titles")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar("phaseChange", 1)
    battlefield:setLocalVar("instantKick", 1)
    -- Need to multiply getArea by 2 due to the two Promathia versions
    local baseID = ID.mob.PROMATHIA_OFFSET + (battlefield:getArea() * 2)
    local pos = GetMobByID(baseID):getSpawnPos()

    local prishe = battlefield:insertEntity(11, true, true)
    prishe:setSpawn(pos.x - 6, pos.y, pos.z - 21.5, 192)
    prishe:spawn()
    prishe:setAllegiance(xi.allegiance.PLAYER)
    prishe:setStatus(xi.status.NORMAL)

    local selhteus = battlefield:insertEntity(12, true, true)
    selhteus:setSpawn(pos.x + 10, pos.y, pos.z - 17.5, 172)
    selhteus:spawn()
    selhteus:setAllegiance(xi.allegiance.PLAYER)
    selhteus:setStatus(xi.status.NORMAL)
end

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
end

battlefieldObject.onBattlefieldDestroy = function(battlefield)
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        -- local name, clearTime, partySize = battlefield:getRecord()
        player:startEvent(6)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option)
end

battlefieldObject.onEventFinish = function(player, csid, option)
end

return battlefieldObject
