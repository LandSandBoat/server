-----------------------------------
-- ID: 5990
-- Scroll of Instant Stoneskin
-- Grants the user a 200 HP Stoneskin effect
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:addStatusEffect(xi.effect.STONESKIN, { power = 200, duration = 300, origin = user, tier = 4 }) then
        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.STONESKIN)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
