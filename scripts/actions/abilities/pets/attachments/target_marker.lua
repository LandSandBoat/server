-----------------------------------
-- Attachment: Target Marker
-- Grants an accuracy bonus to foes higher level than the automaton based on active Thunder Maneuvers.
-- https://wiki.ffo.jp/html/9133.html
-- TODO: Investigate real values. SE claims this code is "very complicated" and this attachment has recieved numerous bug fixes in the ilvl era.
-- These are made up placeholder values, chosen to be slightly stronger than Stabilizer II.
-----------------------------------
---@type TAttachment
local attachmentObject = {}

local accuracyTable =
{
    [0] = 20,
    [1] = 30,
    [2] = 40,
    [3] = 50,
}

attachmentObject.onEquip = function(automaton)
    automaton:addListener('AUTOMATON_AI_TICK', 'AUTO_TARGET_MARKER_TICK', function(pet, target)
        local master = pet:getMaster()

        if not master then
            return
        end

        local thunderManeuvers     = xi.automaton.getManeuverCount(master, master:countEffect(xi.effect.THUNDER_MANEUVER))
        local storedAccuracyBonus  = pet:getLocalVar('targetMarkerAccuracyBonus')
        local updatedAccuracyBonus = accuracyTable[thunderManeuvers] or 0

        -- If target is not higher level than the Automaton, do nothing.
        if pet:getMainLvl() >= target:getMainLvl() then
            if storedAccuracyBonus > 0 then
                pet:delMod(xi.mod.ACC, storedAccuracyBonus)
                pet:delMod(xi.mod.RACC, storedAccuracyBonus)
                pet:setLocalVar('targetMarkerAccuracyBonus', 0)
            end

            return
        end

        -- If the accuracy bonus based on the current number of Thunder Maneuvers is the same as the stored bonus, do nothing.
        if updatedAccuracyBonus == storedAccuracyBonus then
            return
        end

        -- If we make it here, update the accuracy bonus and store the new value as a local variable.
        pet:addMod(xi.mod.ACC, updatedAccuracyBonus - storedAccuracyBonus)
        pet:addMod(xi.mod.RACC, updatedAccuracyBonus - storedAccuracyBonus)
        pet:setLocalVar('targetMarkerAccuracyBonus', updatedAccuracyBonus)
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:removeListener('AUTO_TARGET_MARKER_TICK')

    local accuracyBonus = pet:getLocalVar('targetMarkerAccuracyBonus')
    if accuracyBonus > 0 then
        pet:delMod(xi.mod.ACC, accuracyBonus)
        pet:delMod(xi.mod.RACC, accuracyBonus)
    end

    pet:setLocalVar('targetMarkerAccuracyBonus', 0)
end

return attachmentObject
