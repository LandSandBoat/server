-----------------------------------
-- ID: 6055
-- Item: Aurorastorm Schema
-- Teaches the white magic Aurorastorm
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.AURORASTORM)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.AURORASTORM)
end

return itemObject
