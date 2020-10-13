-----------------------------------------
-- ID: 17624
-- Item: anubiss_knife
-- Item Effect: Poison 1HP / Removes 60 HP over 180 seconds
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    if not target:hasStatusEffect(tpz.effect.POISON) then
        target:addStatusEffect(tpz.effect.POISON, 1, 3, 180)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end
