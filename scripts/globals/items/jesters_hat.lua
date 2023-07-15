-----------------------------------
-- ID: 11788
-- Item: Jester's Hat
-- Item Effect: Casts Cure II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local hpHeal = 90
    local dif = target:getMaxHP() - target:getHP()
    if hpHeal > dif then
        hpHeal = dif
    end

    target:addHP(hpHeal)
    target:updateEnmityFromCure(target, hpHeal)
    target:messageBasic(xi.msg.basic.RECOVERS_HP, 0, hpHeal)
end

return itemObject
