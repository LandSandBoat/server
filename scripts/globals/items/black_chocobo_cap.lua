-----------------------------------
-- ID: 25585
-- Black Chocobo Cap
-- Enchantment: "Teleport" (Upper Jeuno Chocobo Stables)
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.CHOCO_UPPER_JEUNO, 0, 4)
end

return item_object
