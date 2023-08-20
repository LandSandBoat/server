-----------------------------------
-- ID: 14493
-- Item: Healing Vest
-- Item Effect: Restores 90-105 HP
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getHP() == target:getMaxHP() then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    local hpHeal = math.random(90, 105)
    local dif = target:getMaxHP() - target:getHP()
    if hpHeal > dif then
        hpHeal = dif
    end

    target:addHP(hpHeal)
    target:messageBasic(xi.msg.basic.RECOVERS_HP, 0, hpHeal)
end

return itemObject
