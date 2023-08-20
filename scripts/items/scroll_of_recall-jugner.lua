-----------------------------------
-- ID: 4687
-- Scroll of Recall-Jugner
-- Teaches the white magic Recall-Jugner
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.RECALL_JUGNER)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.RECALL_JUGNER)
end

return itemObject
