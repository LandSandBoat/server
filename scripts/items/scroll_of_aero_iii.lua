-----------------------------------
-- ID: 4764
-- Scroll of Aero III
-- Teaches the black magic Aero III
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.AERO_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.AERO_III)
end

return itemObject
