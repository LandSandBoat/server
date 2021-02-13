-----------------------------------
-- Duplicatus Cell
-- ID 5373
-- Unlocks support job
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if target:hasStatusEffect(tpz.effect.OBLIVISCENCE) then
        return 0
    end
    return -1
end

item_object.onItemUse = function(target)
    target:delStatusEffectSilent(tpz.effect.OBLIVISCENCE)
    target:messageText(target, zones[target:getZoneID()].text.CELL_OFFSET + 8)
end

return item_object
