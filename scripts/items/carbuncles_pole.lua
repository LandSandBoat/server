-----------------------------------
-- ID: 18581
-- Item: Carbuncles Pole
-- Item Effect: Restores 160-170 HP
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getHP() == target:getMaxHP() then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    local hpCap  = target:getMaxHP() - target:getHP()
    local hpHeal = utils.clamp(math.random(160, 170), 0, hpCap)
    target:addHP(hpHeal)
    target:messageBasic(xi.msg.basic.RECOVERS_HP, 0, hpHeal)
end

return itemObject
