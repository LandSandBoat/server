-----------------------------------
-- ID: 5041
-- Scroll of Vital Etude
-- Teaches the song Vital Etude
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.VITAL_ETUDE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.VITAL_ETUDE)
end

return itemObject
