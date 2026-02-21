-----------------------------------
-- ID: 11491
-- Snow bunny Hat +1
-- Enchantment: 60Min, Costume - White Rarab
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
    target:addStatusEffect(xi.effect.COSTUME, { power = 270, duration = 3600, origin = user })
end

return itemObject
