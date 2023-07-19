-----------------------------------
-- ID: 5069
-- Scroll of Dark Threnody
-- Teaches the song Dark Threnody
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.DARK_THRENODY)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DARK_THRENODY)
end

return itemObject
