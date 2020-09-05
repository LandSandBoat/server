-----------------------------------------
-- ID: 4441
-- Item: Grape Juice
-- Item Effect: Restores 60 MP over 90 seconds.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    if (not target:hasStatusEffect(tpz.effect.REFRESH)) then
        target:addStatusEffect(tpz.effect.REFRESH, 2, 3, 90)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end
