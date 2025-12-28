-----------------------------------
-- ID: 14759
-- Item: Curaga Earring
-- Item Effect: Casts weak "Curaga"
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

-- Random roll for each target between 50 and 75
-- Cure Pot, Cure Pot II, Cure Pot Received do not work
itemObject.onItemUse = function(target, user, item, action)
    local healAmount = math.random(50, 75)

    healAmount = healAmount * xi.settings.main.CURE_POWER

    local diff = (target:getMaxHP() - target:getHP())
    if healAmount > diff then
        healAmount = diff
    end

    target:addHP(healAmount)
    action:messageID(target:getID(), xi.msg.basic.RECOVERS_HP)

    user:updateEnmityFromCure(target, healAmount) -- You do gain enmity from this

    return healAmount
end

return itemObject
