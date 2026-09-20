-----------------------------------
-- ID: 16867
-- Item: Orc Piercer
-- Additional effect: light damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    if not target:isMob() or target:getFamily() ~= xi.mobFamily.ORC then
        return 0, 0, 0
    end

    local dStat = actor:getStat(xi.mod.MND) - target:getStat(xi.mod.INT)
    local pTable =
    {
        chance         = 10 + utils.clamp(dStat * 0.0926, 0, 5), -- 5% over 54 dMND
        basePower      = math.randomInt(9, 12),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.LIGHT,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
