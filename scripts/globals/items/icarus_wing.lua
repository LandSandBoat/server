-----------------------------------------
-- ID: 4213
-- Icarus Wing
-- Increases TP of the user by 100
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
    target:addTP(1000)
    target:addStatusEffect(tpz.effect.MEDICINE, 0, 0, 7200)
end
