-----------------------------------
-- ID: 15841
-- Recall ring: Jugner
-- Enchantment: "Recall-Jugner"
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if not target:hasKeyItem(xi.ki.JUGNER_GATE_CRYSTAL) then
        result = 445
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.JUGNER, 0, 4)
end

return itemObject
