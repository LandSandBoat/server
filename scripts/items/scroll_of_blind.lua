-----------------------------------
-- ID: 4862
-- Scroll of Blind
-- Teaches the black magic Blind
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BLIND)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLIND)
end

return itemObject
