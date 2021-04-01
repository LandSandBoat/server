-----------------------------------
-- Ancient Flames Beckon
-- Spire of Mea mission battlefield
-----------------------------------
local ID = require("scripts/zones/Spire_of_Mea/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/teleports")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------
local battlefield_object = {}

local function otherLights(player)
    return (player:hasKeyItem(xi.ki.LIGHT_OF_DEM)   and 1 or 0) +
           (player:hasKeyItem(xi.ki.LIGHT_OF_HOLLA) and 1 or 0)
end

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = 1 + otherLights(player)
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 0, battlefield:getLocalVar("[cs]bit"), 0, arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        local teleportTo = xi.teleport.id.EXITPROMMEA
        local ki = xi.ki.LIGHT_OF_MEA

        -- first promyvion completed
        if player:getCurrentMission(COP) == xi.mission.id.cop.BELOW_THE_ARKS then
            player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.BELOW_THE_ARKS)
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS)
            player:setCharVar("cspromy2", 1)
            player:setCharVar("PromathiaStatus", 0)
            player:addKeyItem(ki)
            player:messageSpecial(ID.text.CANT_REMEMBER, ki)

        elseif player:getCurrentMission(COP) == xi.mission.id.cop.THE_MOTHERCRYSTALS and not player:hasKeyItem(ki) then

            -- second promyvion completed
            if otherLights(player) < 2 then
                player:setCharVar("cspromy3", 1)
                player:addKeyItem(ki)
                player:messageSpecial(ID.text.CANT_REMEMBER, ki)

            -- final promyvion completed
            else
                player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS)
                player:setCharVar("PromathiaStatus", 0)
                player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.AN_INVITATION_WEST)
                player:addKeyItem(ki)
                player:messageSpecial(ID.text.CANT_REMEMBER, ki)
                teleportTo = xi.teleport.id.LUFAISE
            end
        end

        player:addExp(1500)
        player:addStatusEffectEx(xi.effect.TELEPORT, 0, teleportTo, 0, 1)
    end
end

return battlefield_object
