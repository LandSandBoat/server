-----------------------------------
-- Attachment: Strobe II
-- http://forum.square-enix.com/ffxi/threads/49065?p=565264#post565264
-- Values are currently PRIOR TO NOVEMBER 2015 UPDATE!
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    updateModPerformance(pet, tpz.mod.ENMITY, 'strobe_ii_mod', 10)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_STROBE_II", function(automaton, target)
        if automaton:getLocalVar("provoke") < VanadielTime() and (automaton:checkDistance(target) - target:getModelSize()) < 7 then
            automaton:useMobAbility(1945)
        else
            return 0
        end
    end)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.ENMITY, 'strobe_ii_mod', 0)
    pet:removeListener("ATTACHMENT_STROBE_II")
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.ENMITY, 'strobe_ii_mod', 10)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.ENMITY, 'strobe_ii_mod', 25)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.ENMITY, 'strobe_ii_mod', 40)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.ENMITY, 'strobe_ii_mod', 60)
    end
end

return attachment_object
