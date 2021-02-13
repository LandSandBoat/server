-----------------------------------
-- Attachment: Strobe
-- http://forum.square-enix.com/ffxi/threads/49065?p=565264#post565264
-- Values are currently PRIOR TO NOVEMBER 2015 UPDATE!
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    updateModPerformance(pet, tpz.mod.ENMITY, 'strobe_mod', 5)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_STROBE", function(automaton, target)
        if automaton:getLocalVar("provoke") < VanadielTime() and (automaton:checkDistance(target) - target:getModelSize()) < 7 then
            automaton:useMobAbility(1945)
        else
            return 0
        end
    end)
end

attachment_object.onUnequip = function(pet)
    updateModPerformance(pet, tpz.mod.ENMITY, 'strobe_mod', 0)
    pet:removeListener("ATTACHMENT_STROBE")
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    attachment_object.onUpdate(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    attachment_object.onUpdate(pet, maneuvers - 1)
end

attachment_object.onUpdate = function(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.ENMITY, 'strobe_mod', 5)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.ENMITY, 'strobe_mod', 10)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.ENMITY, 'strobe_mod', 15)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.ENMITY, 'strobe_mod', 20)
    end
end

return attachment_object
