-----------------------------------
-- ID: 4121
-- Item: X-Potion +1
-- Item Effect: Restores 160 HP
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if (target:getHP() == target:getMaxHP()) then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    elseif (target:hasStatusEffect(xi.effect.MEDICINE)) then
        return xi.msg.basic.ITEM_NO_USE_MEDICATED
    end
    return 0
end

item_object.onItemUse = function(target)
    target:messageBasic(xi.msg.basic.RECOVERS_HP, 0, target:addHP(160*xi.settings.ITEM_POWER))
    target:addStatusEffect(xi.effect.MEDICINE, 0, 0, 5)
end

return item_object
