-----------------------------------
-- ID: 4926
-- Scroll of Watera
-- Teaches the black magic Watera
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.WATERA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATERA)
end

return itemObject
