-----------------------------------
-- ID: 17826
-- Item: Messhikimaru
-- Enchantment: Arcana Killer
-- Durration: 10 Mins
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ARCANE_CIRCLE)
    if effect ~= nil and effect:getItemSourceID() == xi.items.MESSHIKIMARU then
        target:delStatusEffect(xi.effect.ARCANE_CIRCLE)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.MESSHIKIMARU) then
        target:addStatusEffect(xi.effect.ARCANE_CIRCLE, 20, 0, 600, 0, 0, 0, xi.items.MESSHIKIMARU)
    end
end

return itemObject
