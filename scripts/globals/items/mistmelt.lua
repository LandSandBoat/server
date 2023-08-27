-----------------------------------
-- ID: 5265
-- Item: Mistmelt
-- Item Effect: Forces Ouryu to land
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, player)
    local result = 0

    if target:getName() ~= "Ouryu" then
        result = xi.msg.basic.ITEM_UNABLE_TO_USE
    elseif target:checkDistance(player) > 10 then
        result = xi.msg.basic.TOO_FAR_AWAY
    end

    return result
end

itemObject.onItemUse = function(target, player)
    if target:getAnimationSub() == 1 then
        target:delStatusEffect(xi.effect.ALL_MISS)
        target:setMobSkillAttack(0)
        target:setAnimationSub(2)
        target:setLocalVar("changeTime", target:getBattleTime())
    end
end

return itemObject
