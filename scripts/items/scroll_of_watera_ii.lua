-----------------------------------
-- ID: 4927
-- Scroll of Watera II
-- Teaches the black magic Watera II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.WATERA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATERA_II)
end

return itemObject
