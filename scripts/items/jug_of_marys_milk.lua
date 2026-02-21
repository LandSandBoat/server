-----------------------------------
-- ID: 4527
-- Item: Jug of marys milk
-- Item Effect: This potion induces sleep.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if
        not target:hasStatusEffect(xi.effect.SLEEP_I) and
        not target:hasStatusEffect(xi.effect.SLEEP_II) and
        not target:hasStatusEffect(xi.effect.LULLABY)
    then
        target:addStatusEffect(xi.effect.SLEEP_I, { power = 1, duration = 60, origin = user })
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
