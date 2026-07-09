-----------------------------------
-- ID: 18639
-- Item: Excalibur
-- Additional effect: Slashing Damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local pTable =
    {
        chance          = 7,
        basePower       = math.floor(actor:getHP() / 4),
        attackType      = xi.attackType.PHYSICAL,
        physicalElement = xi.damageType.SLASHING,
        magicalElement  = xi.element.NONE,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
