-----------------------------------
-- ID: 4824
-- Scroll of Gravity
-- Teaches the black magic Gravity
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.GRAVITY)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.GRAVITY)
end

return itemObject
