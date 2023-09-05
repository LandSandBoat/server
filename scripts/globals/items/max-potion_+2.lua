-----------------------------------
-- ID: 4126
-- Item: Max-Potion +2
-- Item Effect: Restores 650 HP
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getHP() == target:getMaxHP() then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    elseif target:hasStatusEffect(xi.effect.MEDICINE) then
        return xi.msg.basic.ITEM_NO_USE_MEDICATED
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:messageBasic(xi.msg.basic.RECOVERS_HP, 0, target:addHP(650 * xi.settings.main.ITEM_POWER))
    target:addStatusEffect(xi.effect.MEDICINE, 0, 0, 900)
end

return itemObject
