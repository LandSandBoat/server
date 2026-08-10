-----------------------------------
-- ID: 18200
-- Item: Hydro Axe
-- Additional effect: water damage depending on ammo
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local damageRange = xi.additionalEffect.getConsumableAmmoItemDamageRange(xi.element.WATER, actor:getEquipID(xi.slot.AMMO))

    if not damageRange then
        return 0, 0, 0
    end

    local pTable =
    {
        chance          = 30,
        basePower       = math.randomInt(damageRange[1], damageRange[2]),
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.WATER,
        canMAB          = false,
        canResist       = true,
        lowestResist    = 0.5,
        useAmmo         = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
