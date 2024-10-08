-----------------------------------
-- ID: 4912
-- Scroll of Distract
-- Teaches the black magic Distract
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.DISTRACT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DISTRACT)
end

return itemObject
