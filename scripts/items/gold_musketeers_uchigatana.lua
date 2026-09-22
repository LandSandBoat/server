-----------------------------------
-- ID: 17807
-- Item: Gold Musketeer's Uchigatana
-- Additional effect: Earth damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local pTable =
    {
        chance         = 3 + utils.clamp(dStat * 10 / 54, 0, 10), -- Linear interp over 54 INT
        basePower      = math.randomInt(12, 16),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.EARTH,
        canMAB         = false,
        canResist      = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
