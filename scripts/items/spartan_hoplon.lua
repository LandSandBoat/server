-----------------------------------
-- ID: 15170
-- Item: Spartan Hoplon
-- Item Effect: Phalanx
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:addStatusEffect(xi.effect.PHALANX, { power = 10, duration = 180, origin = user }) then -- Retail potency unknown, 10 is a guess. (someone 1000 needles test this thing!)
        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.PHALANX)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
