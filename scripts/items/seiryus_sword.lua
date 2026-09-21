-----------------------------------
-- ID: 17659
-- Item: Seiryu's Sword
-- Additional effect: water damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local pTable =
    {
        chance         = 2, -- TODO: this has negative scaling, as in if you have low dINT it procs more. This is capped dINT.
        basePower      = math.randomInt(22, 30),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.WATER,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
