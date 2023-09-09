-----------------------------------------
-- ID: 13182
-- Item: Oscar Scarf
-- Item Effect: Enchantment Slighly Bad Breath (inflicts Bind, Paralyze, and Silence on an enemy)
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, player)
    local result = 0
    if target:checkDistance(player) > 10 then
        result = xi.msg.basic.TOO_FAR_AWAY
    end

    return result
end

itemObject.onItemUse = function(target, player)
    local chance = 70
    local effects =
    {
        {
            immunity = xi.immunity.BIND,
            effect = xi.effect.BIND
        },
        {
            immunity = xi.immunity.PARALYZE,
            effect = xi.effect.PARALYSIS
        },
        {
            immunity = xi.immunity.SILENCE,
            effect = xi.effect.SILENCE
        }
    }

    for _, data in ipairs(effects) do
        if target:hasImmunity(data.immunity) or math.random(0, 100) >= chance then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:delStatusEffect(data.effect)
            if not target:hasStatusEffect(data.effect) then
                target:addStatusEffect(data.effect, 10, 0, 30)
            end
        end
    end

    target:updateClaim(player)
end

return itemObject
