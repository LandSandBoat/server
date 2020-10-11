-----------------------------------------
-- ID: 5703
-- Item: Uleguerand Milk
-- Item Effect: Restores 80 HP over 120 seconds
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    if (not target:hasStatusEffect(tpz.effect.REGEN)) then
        target:addStatusEffect(tpz.effect.REGEN, 2, 3, 120)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end
