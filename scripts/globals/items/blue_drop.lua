-----------------------------------------
--  ID: 4263
--  Item: Blue Drop
--  Mind 5
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    if (target:hasStatusEffect(tpz.effect.MEDICINE)) then
        return tpz.msg.basic.ITEM_NO_USE_MEDICATED
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.MND_BOOST, 5, 0, 900)
    target:addStatusEffect(tpz.effect.MEDICINE, 0, 0, 3600)
end
