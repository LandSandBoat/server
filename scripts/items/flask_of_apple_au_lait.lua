-----------------------------------
-- ID: 4300
-- Item: Apple au Lait
-- Item Effect: Restores 120 HP over 180 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:hasStatusEffect(xi.effect.REGEN) then
        target:addStatusEffect(xi.effect.REGEN, { power = 2, duration = 180, origin = user, tick = 3 })
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
