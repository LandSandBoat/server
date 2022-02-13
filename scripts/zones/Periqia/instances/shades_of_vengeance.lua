-----------------------------------
-- TOAU-31: Shades of Vengeance
-- !instance 5600
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
local ID = require("scripts/zones/Periqia/IDs")
-----------------------------------
local instance_object = {}

instance_object.registryRequirements = function(player)
    return player:getCurrentMission(TOAU) == xi.mission.id.toau.SHADES_OF_VENGEANCE and
        player:hasKeyItem(xi.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT)
end

instance_object.entryRequirements = function(player)
    return player:getCurrentMission(TOAU) > xi.mission.id.toau.SHADES_OF_VENGEANCE or
        player:hasKeyItem(xi.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT)
end

instance_object.afterInstanceRegister = function(player)
    local instance = player:getInstance()

    if player:hasKeyItem(xi.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT) then
        player:messageSpecial(ID.text.FADES_INTO_NOTHINGNESS, xi.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT)
        player:delKeyItem(xi.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT)
    end

    player:addTempItem(xi.items.CAGE_OF_DVUCCA_FIREFLIES)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

instance_object.onInstanceCreated = function(instance)
    for i, v in pairs(ID.mob[79]) do
        SpawnMob(v, instance)
    end
end

instance_object.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instance_object.onInstanceFailure = function(instance)
    local chars = instance:getChars()

    for i, v in pairs(chars) do
        if v:getCurrentMission(TOAU) == xi.mission.id.toau.SHADES_OF_VENGEANCE then
            v:setCharVar('Mission[4][30]Timer', VanadielUniqueDay() + 1)
        end

        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(102)
    end
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
    if progress >= 10 and instance:completed() == false then
        instance:complete()
    end
end

instance_object.onInstanceComplete = function(instance)
    local chars = instance:getChars()

    for i, v in pairs(chars) do
        if v:getCurrentMission(TOAU) == xi.mission.id.toau.SHADES_OF_VENGEANCE then
            v:setMissionStatus(xi.mission.log_id.TOAU, 1)
        end

        v:startEvent(102)
    end
end

return instance_object
