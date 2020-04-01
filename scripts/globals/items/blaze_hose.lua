-----------------------------------------
-- ID: 15652
-- Item: Blaze Hose
-- Item Effect: Blaze Spikes
-----------------------------------------

require("scripts/globals/settings")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.BLAZE_SPIKES, 15, 0, 180)
end
