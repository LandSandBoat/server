-----------------------------------
-- ID: 4708
-- Scroll of Enfire
-- Teaches the white magic Enfire
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.ENFIRE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ENFIRE)
end

return itemObject
