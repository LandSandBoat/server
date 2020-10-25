-----------------------------------------
-- ID: 5838
-- Item: tube_of_clear_salve_ii
-- Item Effect: Instantly removes all negative status effects from pet
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")

function onItemCheck(target)
    if (not target:hasPet()) then
        return tpz.msg.basic.REQUIRES_A_PET
    end
    return 0
end

function onItemUse(target)
    local pet = target:getPet()
    
    local function removeStatus()
        if pet:delStatusEffect(tpz.effect.PETRIFICATION) then return true end
        if pet:delStatusEffect(tpz.effect.SILENCE) then return true end
        if pet:delStatusEffect(tpz.effect.BANE) then return true end
        if pet:delStatusEffect(tpz.effect.CURSE_II) then return true end
        if pet:delStatusEffect(tpz.effect.CURSE) then return true end
        if pet:delStatusEffect(tpz.effect.PARALYSIS) then return true end
        if pet:delStatusEffect(tpz.effect.PLAGUE) then return true end
        if pet:delStatusEffect(tpz.effect.POISON) then return true end
        if pet:delStatusEffect(tpz.effect.DISEASE) then return true end
        if pet:delStatusEffect(tpz.effect.BLINDNESS) then return true end
        if pet:eraseStatusEffect() ~= 255 then return true end
        return false
    end
    
    local toremove = 10
    local removed = 0
    
    repeat
        if not removeStatus() then break end
        toremove = toremove - 1
        removed = removed + 1
    until (toremove <= 0)
    
    return removed
end
