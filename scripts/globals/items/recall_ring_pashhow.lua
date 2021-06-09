-----------------------------------
-- ID: 15842
-- Recall ring: Pashhow
-- Enchantment: "Recall-Pashhow"
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/teleports")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:hasKeyItem(xi.ki.PASHHOW_GATE_CRYSTAL) == false) then
        result = 445
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.PASHH, 0, 1)
end

return item_object