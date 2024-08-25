-----------------------------------
-- ID: 4868
-- Scroll of Dispel
-- Teaches the black magic Dispel
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.DISPEL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DISPEL)
end

return itemObject
