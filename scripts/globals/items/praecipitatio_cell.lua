-----------------------------------
-- Praecipitatio Cell
-- ID 5378
-- Unlocks magic
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:hasStatusEffect(xi.effect.OMERTA) then
        return 0
    end

    return -1
end

itemObject.onItemUse = function(target)
    target:delStatusEffectSilent(xi.effect.OMERTA)
    target:messageText(target, zones[target:getZoneID()].text.CELL_OFFSET + 10)
    if target:hasPet() then
        target:getPet():delStatusEffectSilent(xi.effect.OMERTA)
    end
end

return itemObject
