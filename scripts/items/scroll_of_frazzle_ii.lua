-----------------------------------
-- ID: 4915
-- Scroll of Frazzle II
-- Teaches the black magic Frazzle II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.FRAZZLE_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FRAZZLE_II)
end

return itemObject
