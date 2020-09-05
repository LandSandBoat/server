-----------------------------------------
-- ID: 4161
-- Item: Sleeping Potion
-- Item Effect: This potion induces sleep.
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.SLEEP_I, 1, 0, 30)
end

