-----------------------------------
-- ID: 4706
-- Scroll of Enlight
-- Teaches the white magic Enlight
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.ENLIGHT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ENLIGHT)
end

return itemObject
