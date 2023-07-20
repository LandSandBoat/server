-----------------------------------
-- ID: 4946
-- Scroll of Utsusemi: Ichi
-- Teaches the ninjutsu Utsusemi: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.UTSUSEMI_ICHI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.UTSUSEMI_ICHI)
end

return itemObject
