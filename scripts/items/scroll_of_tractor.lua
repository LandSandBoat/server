-----------------------------------
-- ID: 4872
-- Scroll of Tractor
-- Teaches the black magic Tractor
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.TRACTOR)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.TRACTOR)
end

return itemObject
