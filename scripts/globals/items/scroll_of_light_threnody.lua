-----------------------------------
-- ID: 5068
-- Scroll of Light Threnody
-- Teaches the song Light Threnody
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.LIGHT_THRENODY)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.LIGHT_THRENODY)
end

return itemObject
