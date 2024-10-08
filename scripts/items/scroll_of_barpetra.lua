-----------------------------------
-- ID: 4699
-- Scroll of Barpetra
-- Teaches the white magic Barpetra
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BARPETRA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARPETRA)
end

return itemObject
