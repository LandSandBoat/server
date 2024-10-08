-----------------------------------
-- ID: 4700
-- Scroll of Barvira
-- Teaches the white magic Barvira
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BARVIRA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARVIRA)
end

return itemObject
