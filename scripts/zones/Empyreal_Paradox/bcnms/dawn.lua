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
    local baseID = ID.mob.PROMATHIA_OFFSET + (battlefield:getArea() - 1) * 2
    local pos = GetMobByID(baseID):getSpawnPos()

    local prishe = battlefield:insertEntity(11, true, true)
    prishe:setSpawn(pos.x - 6, pos.y, pos.z - 21.5, 192)
    prishe:spawn()

    local selhteus = battlefield:insertEntity(12, true, true)
    selhteus:setSpawn(pos.x + 10, pos.y, pos.z - 17.5, 172)
    selhteus:spawn()
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
    if csid == 6 then
        player:setPos(539, 0, -593, 192)
        player:addTitle(xi.title.AVERTER_OF_THE_APOCALYPSE)
        player:startEvent(3)
        if
            player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.DAWN and
            player:getCharVar("PromathiaStatus") == 2
        then
            player:addKeyItem(xi.ki.TEAR_OF_ALTANA)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TEAR_OF_ALTANA)
            player:setCharVar("Promathia_kill_day", getMidnight())
            player:setCharVar("PromathiaStatus", 3)
        end
    end
end

return battlefieldObject
