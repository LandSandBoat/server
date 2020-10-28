-----------------------------------------
-- ID: 5838
-- Item: tube_of_clear_salve_ii
-- Item Effect: Instantly removes all negative status effects from pet
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")

function onItemCheck(target)
    if not target:hasPet() then
        return tpz.msg.basic.REQUIRES_A_PET
    end
    return 0
end

function onItemUse(target)
    local pet = target:getPet()
    
    local effects = {
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

    local count = 10
    local statusEffectTable = effects

    local function removeStatus()
        for _, effect in ipairs(statusEffectTable) do
            if pet:delStatusEffect(effect) then return true end
        end
        if pet:eraseStatusEffect() ~= 255 then return true end
        return false
    end

    local removed = 0

    for i = 0, count do
        if not removeStatus() then break end
        removed = removed + 1
        if removed >= count then break end
    end

    return removed
end
