-----------------------------------
-- ID: 5063
-- Scroll of Ice Threnody
-- Teaches the song Ice Threnody
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ICE_THRENODY)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ICE_THRENODY)
end

return itemObject
