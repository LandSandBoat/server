-----------------------------------
-- ID: 5268
-- Item: CCB Polymer Pump
-- Used during CoP 6-4 One To Be Feared on Ultima or Omega to inflict a 1 minute amnesia
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result      = xi.msg.basic.ITEM_UNABLE_TO_USE
    local battlefield = caster:getBattlefieldID()

    if
        battlefield == xi.battlefield.id.ONE_TO_BE_FEARED and
        (target:getName() == 'Omega' or target:getName() == 'Ultima') and
        not target:hasStatusEffect(xi.effect.AMNESIA)
    then
        result = 0
    elseif target:checkDistance(caster) > 10 then
        result = xi.msg.basic.TOO_FAR_AWAY
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.AMNESIA, 1, 0, 60)
end

return itemObject
