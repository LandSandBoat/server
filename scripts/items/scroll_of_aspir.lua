-----------------------------------
-- ID: 4855
-- Scroll of Aspir
-- Teaches the black magic Aspir
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.ASPIR)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ASPIR)
end

return itemObject
