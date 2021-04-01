-----------------------------------
-- Praecipitatio Cell
-- ID 5378
-- Unlocks magic
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if target:hasStatusEffect(xi.effect.OMERTA) then
        return 0
    end
    return -1
end

item_object.onItemUse = function(target)
    target:delStatusEffectSilent(xi.effect.OMERTA)
    target:messageText(target, zones[target:getZoneID()].text.CELL_OFFSET + 10)
end

return item_object
