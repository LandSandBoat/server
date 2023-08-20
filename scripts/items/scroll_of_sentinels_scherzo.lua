-----------------------------------
-- ID: 5078
-- Scroll of Sentinel's Scherzo
-- Teaches the song Sentinel's Scherzo
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SENTINELS_SCHERZO)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SENTINELS_SCHERZO)
end

return itemObject
