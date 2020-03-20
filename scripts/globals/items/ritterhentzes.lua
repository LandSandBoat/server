-----------------------------------------
-- ID: 15652
-- Item: ritter
-- Item Effect: Blaze Spikes
-----------------------------------------

require("scripts/globals/settings")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.BLAZE_SPIKES, 20, 0, 210)
end
