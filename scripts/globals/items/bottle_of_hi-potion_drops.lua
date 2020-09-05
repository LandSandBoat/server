-----------------------------------------
-- ID: 5328
-- Item: Hi-Potion Drop
-- Item Effect: Restores 110 HP
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    if (target:hasStatusEffect(tpz.effect.MEDICINE)) then
        return tpz.msg.basic.ITEM_NO_USE_MEDICATED
    end
    return 0
end

function onItemUse(target)
    target:addHP(110*ITEM_POWER)
    target:addStatusEffect(tpz.effect.MEDICINE, 0, 0, 300)
end
