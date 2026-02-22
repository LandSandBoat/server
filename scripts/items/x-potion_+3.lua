-----------------------------------
-- ID: 4123
-- Item: X-Potion +3
-- Item Effect: Restores 180 HP
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getHP() == target:getMaxHP() then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    elseif target:hasStatusEffect(xi.effect.MEDICINE) then
        return xi.msg.basic.ITEM_NO_USE_MEDICATED
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    target:messageBasic(xi.msg.basic.RECOVERS_HP, 0, target:addHP(180 * xi.settings.main.ITEM_POWER))
    target:addStatusEffect(xi.effect.MEDICINE, { duration = 5, origin = user })
end

return itemObject
