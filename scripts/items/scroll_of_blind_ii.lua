-----------------------------------
-- ID: 4884
-- Scroll of Blind II
-- Teaches the black magic Blind II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BLIND_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLIND_II)
end

return itemObject
