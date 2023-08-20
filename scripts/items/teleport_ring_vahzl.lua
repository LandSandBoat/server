-----------------------------------
-- ID: 14664
-- Teleport ring: Vahzl
-- Enchantment: "Teleport-Vahzl"
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if not target:hasKeyItem(xi.ki.VAHZL_GATE_CRYSTAL) then
        result = 445
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.VAHZL, 0, 1)
end

return itemObject
