-----------------------------------------
-- ID: 15162
-- Item: Mist Crown
-- Item Effect: Evasion Boost
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    if (not target:hasStatusEffect(tpz.effect.EVASION_BOOST)) then
        target:addStatusEffect(tpz.effect.EVASION_BOOST, 15, 0, 180)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end
