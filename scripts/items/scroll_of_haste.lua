-----------------------------------
-- ID: 4665
-- Scroll of Haste
-- Teaches the white magic Haste
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.HASTE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HASTE)
end

return itemObject
