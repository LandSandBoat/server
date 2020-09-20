-----------------------------------------
-- ID: 4558
-- Item: Yagudo Drink
-- Item Effect: Restores 120 MP over 3 minutes
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    if (not target:hasStatusEffect(tpz.effect.REFRESH)) then
        target:addStatusEffect(tpz.effect.REFRESH, 2, 3, 180)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end
