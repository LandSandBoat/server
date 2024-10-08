-----------------------------------
-- ID: 4674
-- Scroll of Barfira
-- Teaches the white magic Barfira
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BARFIRA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARFIRA)
end

return itemObject
