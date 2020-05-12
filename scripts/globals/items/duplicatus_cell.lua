-----------------------------------------
-- Duplicatus Cell
-- ID 5373
-- Unlocks support job
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    if target:hasStatusEffect(tpz.effect.OBLIVISCENCE) then
        return 0
    end
    return -1
end

function onItemUse(target)
    target:delStatusEffectSilent(tpz.effect.OBLIVISCENCE)
    target:messageText(target, zones[target:getZoneID()].text.CELL_OFFSET + 8)
end
