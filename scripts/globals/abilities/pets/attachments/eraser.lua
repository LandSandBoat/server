-----------------------------------
-- Attachment: Eraser
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

local removable = {
    tpz.effect.PETRIFICATION,
    tpz.effect.SILENCE,
    tpz.effect.BANE,
    tpz.effect.CURSE_II,
    tpz.effect.CURSE_I,
    tpz.effect.PARALYSIS,
    tpz.effect.PLAGUE,
    tpz.effect.POISON,
    tpz.effect.DISEASE,
    tpz.effect.BLINDNESS
}

function onEquip(pet)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_ERASER", function(automaton, target)
        local master = automaton:getMaster()
        if not automaton:hasRecast(tpz.recast.ABILITY, 2021) and master and master:countEffect(tpz.effect.LIGHT_MANEUVER) > 0 then
            local erasetarget = false

            local function checkEffects(entity)
                for _, status in pairs(removable) do
                    if entity:hasStatusEffect(status) then return true end
                end
                return false
            end

            if automaton:hasStatusEffectByFlag(tpz.effectFlag.ERASABLE) or checkEffects(automaton) then
                erasetarget = automaton
            elseif (automaton:checkDistance(master) - master:getModelSize()) < 7 and (master:hasStatusEffectByFlag(tpz.effectFlag.ERASABLE) or checkEffects(master)) then
                erasetarget = master
            end

            if not erasetarget then return 0 end
            automaton:useMobAbility(2021, erasetarget)
        else
            return 0
        end
    end)
end

function onUnequip(pet)
    pet:removeListener("ATTACHMENT_ERASER")
end

function onManeuverGain(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
end

return attachment_object
