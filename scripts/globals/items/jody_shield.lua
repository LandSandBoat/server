-----------------------------------
-- ID: 27623
-- Jody Shield
-- Enchantment: Jody's Meet and Greet
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/teleports")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.WAJAOM_JODY, 0, 1)
end

return itemObject
