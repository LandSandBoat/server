-----------------------------------
-- ID: 4721
-- Scroll of Repose
-- Teaches the white magic Repose
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.REPOSE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.REPOSE)
end

return itemObject
