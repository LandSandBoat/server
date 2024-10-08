-----------------------------------
-- ID: 4782
-- Scroll of Firaga
-- Teaches the black magic Firaga
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.FIRAGA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRAGA)
end

return itemObject
