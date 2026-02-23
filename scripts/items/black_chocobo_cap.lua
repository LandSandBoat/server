-----------------------------------
-- ID: 25585
-- Black Chocobo Cap
-- Enchantment: "Teleport" (Upper Jeuno Chocobo Stables)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.CHOCO_UPPER_JEUNO, duration = 4, origin = user, icon = 0 })
end

return itemObject
