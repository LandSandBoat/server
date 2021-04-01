-----------------------------------
-- Attachment: Target Marker
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    pet:addListener("ENGAGE", "AUTO_TARGETMARKER_ENGAGE", function(pet, target)
        local ignored = pet:getLocalVar("targetmarker")
        if ignored > 0 then
            pet:delMod(xi.mod.ACC, ignored)
            pet:setLocalVar("targetmarker", 0)
        end

        if pet:getMainLvl() < target:getMainLvl() then
            local master = pet:getMaster()
            local maneuvers = master:countEffect(xi.effect.THUNDER_MANEUVER)
            local eva = target:getEVA()
            local percentage = 0.05
            if maneuvers == 1 then
                percentage = 0.15
            elseif maneuvers == 2 then
                percentage = 0.30
            elseif maneuvers == 3 then
                percentage = 0.45
            end
            local accbonus = math.floor(eva * percentage)
            pet:addMod(xi.mod.ACC, accbonus)
            pet:setLocalVar("targetmarker", accbonus)
        end
    end)
    pet:addListener("DISENGAGE", "AUTO_TARGETMARKER_DISENGAGE", function(pet)
        local ignored = pet:getLocalVar("targetmarker")
        if ignored > 0 then
            pet:delMod(xi.mod.ACC, ignored)
            pet:setLocalVar("targetmarker", 0)
        end
    end)
end

attachment_object.onUnequip = function(pet)
    pet:removeListener("AUTO_TARGETMARKER_ENGAGE")
    pet:removeListener("AUTO_TARGETMARKER_DISENGAGE")
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    local ignored = pet:getLocalVar("targetmarker")
    local target = pet:getTarget()
    if ignored > 0 and target then
        local eva = target:getEVA()
        local percentage = 0.05
        if maneuvers == 1 then
            percentage = 0.15
        elseif maneuvers == 2 then
            percentage = 0.30
        elseif maneuvers == 3 then
            percentage = 0.45
        end
        local accbonus = math.floor(eva * percentage)
        pet:addMod(xi.mod.ACC, accbonus - ignored)
        pet:setLocalVar("targetmarker", accbonus)
    end
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    local ignored = pet:getLocalVar("targetmarker")
    local target = pet:getTarget()
    if ignored > 0 and target then
        local eva = target:getEVA()
        local percentage = 0.05
        if maneuvers == 1 then
            percentage = 0.05
        elseif maneuvers == 2 then
            percentage = 0.15
        elseif maneuvers == 3 then
            percentage = 0.30
        end
        local accbonus = math.floor(eva * percentage)
        pet:delMod(xi.mod.ACC, ignored - accbonus)
        pet:setLocalVar("targetmarker", accbonus)
    end
end

return attachment_object
