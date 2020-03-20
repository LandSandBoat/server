-----------------------------------------
-- Opacus Cell
-- 5374
-- Unlocks job abilities, weapon skills
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    if target:hasStatusEffect(tpz.effect.IMPAIRMENT) then
        return 0
    end
    return -1
end

function onItemUse(target)
    target:delStatusEffectSilent(tpz.effect.IMPAIRMENT)
    target:messageText(target, zones[target:getZoneID()].text.CELL_OFFSET + 9)
end
