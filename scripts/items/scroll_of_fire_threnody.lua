-----------------------------------
-- ID: 5062
-- Scroll of Fire Threnody
-- Teaches the song Fire Threnody
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FIRE_THRENODY)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRE_THRENODY)
end

return itemObject
