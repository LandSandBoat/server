-----------------------------------
-- ID: 6058
-- Klimaform Schema
-- Teaches the black magic Klimaform
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.KLIMAFORM)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.KLIMAFORM)
end

return itemObject
