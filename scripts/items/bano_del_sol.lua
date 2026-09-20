-----------------------------------
-- ID: 17981
-- Item: Bano Del Sol
-- Additional effect: light damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local species = target:isMob() and target:getSpecies() or xi.mobSpecies.UNCLASSIFIED

    if species ~= xi.mobSpecies.SLIME and species ~= xi.mobSpecies.CLOT then
        return 0, 0, 0
    end

    local pTable =
    {
        chance         = 10, -- TODO: this probably scales with dINT but sample sizes are insanely low.
        basePower      = math.randomInt(39, 42),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.LIGHT,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
