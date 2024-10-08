-----------------------------------
-- ID: 4807
-- Scroll of Waterga
-- Teaches the black magic Waterga
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.WATERGA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATERGA)
end

return itemObject
