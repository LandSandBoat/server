-----------------------------------------
-- ID: 5836
-- Item: tube_of_healing_salve_ii
-- Item Effect: Instantly restores 100% of pet HP
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
    local totalHP = pet:getMaxHP()
    pet:addHP(totalHP)
    pet:messageBasic(tpz.msg.basic.RECOVERS_HP, 0, totalHP)
end
