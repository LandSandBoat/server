-----------------------------------
-- ID: 5066
-- Scroll of Lightning Threnody
-- Teaches the song Lightning Threnody
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.LIGHTNING_THRENODY)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.LIGHTNING_THRENODY)
end

return itemObject
