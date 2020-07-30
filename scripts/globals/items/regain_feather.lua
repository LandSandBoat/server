-----------------------------------------
-- ID: 5260
-- Item: Regain Feather
-- Status Effect: Medicated, 2 hours
-- Instantly restors HP/MP full TP
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    if (target:hasStatusEffect(tpz.effect.MEDICINE)) then
        return tpz.msg.basic.ITEM_NO_USE_MEDICATED
    end
    return 0
end

function onItemUse(target)
    target:setHP(target:getMaxHP())
    target:setMP(target:getMaxMP())
    target:setTP(3000)
    target:addStatusEffect(tpz.effect.MEDICINE, 0, 0, 7200)
end
