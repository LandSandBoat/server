-----------------------------------
-- ID: 16956
-- Item: Skofnung
-- Additional effect: light damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local family = target:isMob() and target:getFamily() or xi.mobFamily.UNCLASSIFIED

    if family ~= xi.mobFamily.GIGAS then
        return 0, 0, 0
    end

    local pTable =
    {
        chance         = 15,
        basePower      = math.randomInt(15, 20),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.LIGHT,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
