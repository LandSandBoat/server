-----------------------------------
-- ID: 4890
-- Scroll of Firaja
-- Teaches the black magic Firaja
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.FIRAJA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRAJA)
end

return itemObject
