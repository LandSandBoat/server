-----------------------------------
-- ID: 5297
-- Mithran Rice Cake
-- Enchantment: 60Min, Costume - Mithra Child
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if not target:canUseMisc(xi.zoneMisc.COSTUME) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.COSTUME, { power = 182, duration = 3600, origin = user })
end

return itemObject
