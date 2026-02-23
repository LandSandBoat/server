-----------------------------------
-- ID: 5262
-- Item: Bottle Of Hysteroanima
-- Item Effect: HYSTERIA
-- TODO: The mobskill actually finishes but with no animation,
--       and the category changes to 7 instead of 11 (mobskill finish)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    if target:getEcosystem() ~= xi.ecosystem.EMPTY then -- Empty
        result = xi.msg.basic.ITEM_UNABLE_TO_USE
    elseif target:checkDistance(caster) > 10 then
        result = xi.msg.basic.TOO_FAR_AWAY
    end

    return result
end

itemObject.onItemUse = function(target, player)
    target:delStatusEffectSilent(xi.effect.HYSTERIA)
    target:addStatusEffect(xi.effect.HYSTERIA, { power = 1, duration = math.random(25, 32), origin = player, flag = xi.effectFlag.NO_LOSS_MESSAGE })
end

return itemObject
