-----------------------------------
-- ID: 4509
-- Item: Flask of distilled water
-- Item Effect: While Sha Wujing's Lance +1 is equipped:
--   5m 1HP/tick Regen effect. Lance does not need to remain equipped after use.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user, item, action)
    local regenEffect = target:getStatusEffect(xi.effect.REGEN)

    if
        target:getMod(xi.mod.DRINK_DISTILLED) == 1 and -- TODO: Are there other items that need this? Could probably just check if the spear is equipped...
        (not regenEffect or regenEffect:getTier() == 0)
    then
        target:delStatusEffectSilent(xi.effect.REGEN) -- All Regen items overwrite freely, and their effect expires silently if overwritten.

        target:addStatusEffect(xi.effect.REGEN, { power = 1, duration = 300, origin = user, tick = 3 })
    else
        action:messageID(target:getID(), xi.msg.basic.ITEM_NO_EFFECT) -- Displays no effect when Lance is not equipped or attempting to overwrite tier 1, 2, 3, 4 or 5 Regen.

        return 0
    end
end

return itemObject
