-----------------------------------
-- ID: 4378
-- Item: Jug of Selbina Milk
-- Item Effect: regen: 1 HP/tick x 120sec, x 150sec w/ dream robe +1
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user, item, action)
    local regenEffect   = target:getStatusEffect(xi.effect.REGEN)
    local bodyEquipped  = target:getEquipID(xi.slot.BODY)
    local regenDuration = bodyEquipped == xi.item.DREAM_ROBE_P1 and 150 or 120

    if
        not regenEffect or
        regenEffect:getTier() == 0
    then
        target:delStatusEffectSilent(xi.effect.REGEN) -- All Regen items overwrite freely, and their effect expires silently if overwritten.

        target:addStatusEffect(xi.effect.REGEN, { power = 1, duration = regenDuration, origin = user, tick = 3 })
    else
        action:messageID(target:getID(), xi.msg.basic.ITEM_NO_EFFECT) -- Displays no effect when attempting to overwrite tier 1, 2, 3, 4 or 5 Regen.

        return 0
    end
end

return itemObject
