-----------------------------------
-- ID: 4894
-- Scroll of Thundaj
-- Teaches the black magic Thundaj
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.THUNDAJA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.THUNDAJA)
end

return itemObject
