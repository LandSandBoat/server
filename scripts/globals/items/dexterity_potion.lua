-----------------------------------------
--  ID: 4201
--  Item: Dexterity Potion
--  Dexterity 7
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
    target:addStatusEffect(tpz.effect.DEX_BOOST, 7, 0, 180)
    target:addStatusEffect(tpz.effect.MEDICINE, 0, 0, 900)
end
