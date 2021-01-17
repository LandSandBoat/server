-----------------------------------
-- Attachment: Strobe
-- http://forum.square-enix.com/ffxi/threads/49065?p=565264#post565264
-- Values are currently PRIOR TO NOVEMBER 2015 UPDATE!
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    updateModPerformance(pet, tpz.mod.ENMITY, 'strobe_mod', 5)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_STROBE", function(automaton, target)
        if automaton:getLocalVar("provoke") < VanadielTime() and (automaton:checkDistance(target) - target:getModelSize()) < 7 then
            automaton:useMobAbility(1945)
        else
            return 0
        end
    end)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.ENMITY, 'strobe_mod', 0)
    pet:removeListener("ATTACHMENT_STROBE")
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
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
