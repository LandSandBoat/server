-----------------------------------
-- xi.effect.DYNAMIS
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:setLocalVar("dynamis_lasttimeupdate", effect:getTimeRemaining() / 1000)
end

effectObject.onEffectTick = function(target, effect)
    if target:getCurrentRegion() == xi.region.DYNAMIS then
        local lastTimeUpdate = target:getLocalVar("dynamis_lasttimeupdate")
        local remainingTimeLimit = effect:getTimeRemaining() / 1000
        local message = 0

        if lastTimeUpdate > 600 and remainingTimeLimit < 600 then
            message = 600
        elseif lastTimeUpdate > 300 and remainingTimeLimit < 300 then
            message = 300
        elseif lastTimeUpdate > 60 and remainingTimeLimit < 60 then
            message = 60
        elseif lastTimeUpdate > 30 and remainingTimeLimit < 30 then
            message = 30
        elseif lastTimeUpdate > 10 and remainingTimeLimit < 10 then
            message = 10
        end

        if message ~= 0 then
            local time = message
            local minutes = 0
            if time >= 60 then
                minutes = 1
                time = time / 60
            end

            if time == 1 then
                target:messageSpecial(zones[target:getZoneID()].text.DYNAMIS_TIME_UPDATE_1, time, minutes)
            else
                target:messageSpecial(zones[target:getZoneID()].text.DYNAMIS_TIME_UPDATE_2, time, minutes)
            end

            target:setLocalVar("dynamis_lasttimeupdate", message)
        end
    else
        target:delStatusEffectSilent(xi.effect.DYNAMIS)
    end
end

effectObject.onEffectLose = function(target, effect)
    target:delKeyItem(xi.ki.CRIMSON_GRANULES_OF_TIME)
    target:delKeyItem(xi.ki.AZURE_GRANULES_OF_TIME)
    target:delKeyItem(xi.ki.AMBER_GRANULES_OF_TIME)
    target:delKeyItem(xi.ki.ALABASTER_GRANULES_OF_TIME)
    target:delKeyItem(xi.ki.OBSIDIAN_GRANULES_OF_TIME)
    if target:getCurrentRegion() == xi.region.DYNAMIS then
        if effect:getTimeRemaining() == 0 then
            target:messageSpecial(zones[target:getZoneID()].text.DYNAMIS_TIME_EXPIRED)
            target:disengage()
            target:startCutscene(100)
        end
    end
end

return effectObject
