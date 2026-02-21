-----------------------------------
-- ID: 14666
-- Teleport ring: Altep
-- Enchantment: "Teleport-Altep"
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    if not target:hasKeyItem(xi.ki.ALTEPA_GATE_CRYSTAL) then
        result = 445
    end

    return result
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.ALTEP, duration = 4, origin = user, icon = 0 })
end

return itemObject
