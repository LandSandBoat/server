-----------------------------------
-- ID: 4688
-- Scroll of Recall-Pashh
-- Teaches the white magic Recall-Pashh
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.RECALL_PASHH)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.RECALL_PASHH)
end

return itemObject
