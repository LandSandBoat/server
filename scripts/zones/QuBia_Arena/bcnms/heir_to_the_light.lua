-----------------------------------
-- Heir to the Light
-- Qu'Bia Arena mission battlefield
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
local ID = require("scripts/zones/QuBia_Arena/IDs")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar("phaseChange", 1)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getCurrentMission(SANDORIA) ~= xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32004 then
        local battlefield = player:getBattlefield()
        if battlefield then
            local inst = battlefield:getArea()
            local instOffset = ID.mob.HEIR_TO_THE_LIGHT_OFFSET + (14 * (inst-1))
            local allyPos =
            {
                [1] = { trionPos = {-403, -201,  413, 58}, playerPos = {-400, -201,  419, 61} },
                [2] = { trionPos = {  -3,   -1,    4, 61}, playerPos = {   0,   -1,   10, 61} },
                [3] = { trionPos = { 397,  198, -395, 64}, playerPos = { 399,  198, -381, 57} },
            }

            -- spawn Warlord Rojnoj and its right and left hands.
            for i = instOffset + 0, instOffset + 2 do
                SpawnMob(i)
            end

            -- spawn trion and set ally positions
            local allies = battlefield:getAllies()
            if #allies == 0 then
                local trion = battlefield:insertEntity(75, true, true)
                trion:setSpawn(unpack(allyPos[inst].trionPos))
                trion:spawn()
            end
            player:setPos(unpack(allyPos[inst].playerPos))
        end
    elseif csid == 32001 and
        player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and
        player:getCharVar("MissionStatus") == 3
    then
        player:setCharVar("MissionStatus", 4)
    end
end

return battlefield_object
