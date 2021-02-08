-----------------------------------
-- TOAU-31: Shades of Vengeance
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
local ID = require("scripts/zones/Periqia/IDs")
local instance_helpers = require("scripts/globals/instance")
-----------------------------------
local instance_object = {}

instance_object.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

instance_object.onInstanceCreated = function(instance)
    for i, v in pairs(ID.mob[79]) do
        SpawnMob(v, instance)
    end
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    instance_helpers.updateInstanceTime(instance, elapsed, ID.text)
end

instance_object.onInstanceFailure = function(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(102)
    end
end

instance_object.onInstanceProgressUpdate = function(instance, progress)

    if (progress >= 10 and instance:completed() == false) then
        instance:complete()
    end

end

instance_object.onInstanceComplete = function(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        if (v:getCurrentMission(TOAU) == tpz.mission.id.toau.SHADES_OF_VENGEANCE) then
            v:setCharVar("AhtUrganStatus", 1)
        end

        v:startEvent(102)
    end

end

instance_object.onEventUpdate = function(player, csid, option)
end

instance_object.onEventFinish = function(player, csid, option)
end

return instance_object
