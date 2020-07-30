-----------------------------------------
-- ID: 4302
-- Item: Pamama au Lait
-- Item Effect: Restores 400 HP over 600 seconds
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    if (not target:hasStatusEffect(tpz.effect.REGEN)) then
        target:addStatusEffect(tpz.effect.REGEN, 2, 3, 600)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end
