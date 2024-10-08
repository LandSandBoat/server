-----------------------------------
-- ID: 4804
-- Scroll of Thundaga III
-- Teaches the black magic Thundaga III
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.THUNDAGA_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.THUNDAGA_III)
end

return itemObject
