-----------------------------------
-- ID: 4687
-- Scroll of Recall-Jugner
-- Teaches the white magic Recall-Jugner
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.RECALL_JUGNER)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.RECALL_JUGNER)
end

return itemObject
