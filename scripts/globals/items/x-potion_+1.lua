-----------------------------------
-- ID: 4121
-- Item: X-Potion +1
-- Item Effect: Restores 160 HP
-----------------------------------
require("scripts/globals/msg")
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
    target:messageBasic(xi.msg.basic.RECOVERS_HP, 0, target:addHP(160 * xi.settings.main.ITEM_POWER))
    target:addStatusEffect(xi.effect.MEDICINE, 0, 0, 5)
end

return itemObject
