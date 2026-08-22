-----------------------------------
-- ID: 4301
-- Item: Persikos au Lait
-- Item Effect: Restores 800 HP over 600 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user, item, action)
    local regenEffect = target:getStatusEffect(xi.effect.REGEN)

    if
        not regenEffect or
        regenEffect:getTier() == 0
    then
        target:delStatusEffectSilent(xi.effect.REGEN) -- All Regen items overwrite freely, and their effect expires silently if overwritten.

        target:addStatusEffect(xi.effect.REGEN, { power = 4, duration = 600, origin = user, tick = 3 })
    else
        action:messageID(target:getID(), xi.msg.basic.ITEM_NO_EFFECT) -- Displays no effect when attempting to overwrite tier 1, 2, 3, 4 or 5 Regen.

        return 0
    end
end

return itemObject
