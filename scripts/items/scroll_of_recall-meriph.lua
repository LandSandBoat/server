-----------------------------------
-- ID: 4689
-- Scroll of Recall-Meriph
-- Teaches the white magic Recall-Meriph
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.RECALL_MERIPH)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.RECALL_MERIPH)
end

return itemObject
