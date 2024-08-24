-----------------------------------
-- ID: 4981
-- Scroll of Foe Requiem VI
-- Teaches the song Foe Requiem VI
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.FOE_REQUIEM_VI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FOE_REQUIEM_VI)
end

return itemObject
