-----------------------------------
-- ID: 16720
-- Item: Plantbane
-- Additional effect: fire damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    if target:getEcosystem() ~= xi.ecosystem.PLANTOID then
        return 0, 0, 0
    end

    local pTable =
    {
        chance          = 10, -- TODO: this probably scales with dINT but sample sizes are insanely low.
        basePower       = math.randomInt(9, 12),
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.FIRE,
        canMAB          = false,
        canResist       = true,
        lowestResist    = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
