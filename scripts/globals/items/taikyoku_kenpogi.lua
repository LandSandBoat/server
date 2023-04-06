-----------------------------------
-- ID: 14541
-- Item: taikyoku_kenpogi
-- Item Effect: Eva +3
-- Duration: 30 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.EVASION_BOOST)
    if effect ~= nil and effect:getItemSourceID() == xi.items.TAIKYOKU_KENPOGI then
        target:delStatusEffect(xi.effect.EVASION_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.TAIKYOKU_KENPOGI) then
        target:addStatusEffect(xi.effect.EVASION_BOOST, 3, 0, 1800, 0, 0, 0, xi.items.TAIKYOKU_KENPOGI)
    end
end

return itemObject
