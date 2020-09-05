-----------------------------------
--
--     tpz.effect.DYNAMIS
--
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target, effect)
    target:setLocalVar("dynamis_lasttimeupdate", effect:getTimeRemaining() / 1000)
end

-----------------------------------
-- onEffectTick Action
-----------------------------------

function onEffectTick(target, effect)
    if target:getCurrentRegion() == tpz.region.DYNAMIS then
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
        target:delStatusEffectSilent(tpz.effect.DYNAMIS)
    end
end

-----------------------------------
-- onEffectLose Action
-----------------------------------

function onEffectLose(target, effect)
    target:delKeyItem(tpz.ki.CRIMSON_GRANULES_OF_TIME)
    target:delKeyItem(tpz.ki.AZURE_GRANULES_OF_TIME)
    target:delKeyItem(tpz.ki.AMBER_GRANULES_OF_TIME)
    target:delKeyItem(tpz.ki.ALABASTER_GRANULES_OF_TIME)
    target:delKeyItem(tpz.ki.OBSIDIAN_GRANULES_OF_TIME)
    if target:getCurrentRegion() == tpz.region.DYNAMIS then
        if effect:getTimeRemaining() == 0 then
            target:messageSpecial(zones[target:getZoneID()].text.DYNAMIS_TIME_EXPIRED)
            target:disengage()
            target:startEvent(100)
        end
    end
end

function onEventUpdate(target, csid, option)
    -- printf("onUpdate CSID: %u", csid)
    -- printf("onUpdate RESULT: %u", option)
end

function onEventFinish(target, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)
end
