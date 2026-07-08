-----------------------------------
-- Attachment: Pattern Reader
-- Increases evasion against current target every tick based on the number of Wind Maneuvers active. Caps at 30 evasion.
-- Evasion bonus resets when switching targets.
-----------------------------------
---@type TAttachment
local attachmentObject = {}

local evasionPerTick =
{
    [0] = 0,
    [1] = 1,
    [2] = 2,
    [3] = 3,
}

attachmentObject.onEquip = function(automaton)
    automaton:addListener('AUTOMATON_AI_TICK', 'AUTO_PATTERN_READER_TICK', function(pet, target)
        local patternReaderEvasionBonus = pet:getLocalVar('patternReaderEvasionBonus')
        local currentTarget             = target:getID()
        local patternReaderTarget       = pet:getLocalVar('patternReaderTarget')

        -- If the current target is not the same as our stored target, reset evasion bonus and store the new target.
        if currentTarget ~= patternReaderTarget then
            if patternReaderEvasionBonus > 0 then
                pet:delMod(xi.mod.EVA, patternReaderEvasionBonus)
            end

            pet:setLocalVar('patternReaderEvasionBonus', 0)
            pet:setLocalVar('patternReaderTarget', currentTarget)
            return
        end

        local master = pet:getMaster()

        if not master then
            return
        end

        local windManeuvers = xi.automaton.getManeuverCount(master, master:countEffect(xi.effect.WIND_MANEUVER))

        if windManeuvers == 0 then
            return
        end

        if patternReaderEvasionBonus >= 30 then
            return
        end

        -- Calculate the new evasion bonus based on the number of Wind Maneuvers and apply it if it's greater than the current bonus. Clamped to a maximum of 30.
        local evasionBonus = math.min(30, patternReaderEvasionBonus + (evasionPerTick[windManeuvers] or 0))
        local evasionDelta = evasionBonus - patternReaderEvasionBonus

        if evasionDelta > 0 then
            pet:addMod(xi.mod.EVA, evasionDelta)
            pet:setLocalVar('patternReaderEvasionBonus', evasionBonus)
        end
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:removeListener('AUTO_PATTERN_READER_TICK')

    local patternReaderEvasionBonus = pet:getLocalVar('patternReaderEvasionBonus')
    if patternReaderEvasionBonus > 0 then
        pet:delMod(xi.mod.EVA, patternReaderEvasionBonus)
    end

    pet:setLocalVar('patternReaderEvasionBonus', 0)
    pet:setLocalVar('patternReaderTarget', 0)
end

return attachmentObject
