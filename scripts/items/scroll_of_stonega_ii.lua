-----------------------------------
-- ID: 4798
-- Scroll of Stonega II
-- Teaches the black magic Stonega II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.STONEGA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.STONEGA_II)
end

return itemObject
