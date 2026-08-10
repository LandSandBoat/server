-----------------------------------
-- ID: 18367
-- Item: Gust Claymore +1
-- Additional effect: Wind damage depending on ammo
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local damageRange = xi.additionalEffect.getConsumableAmmoItemDamageRange(xi.element.WIND, actor:getEquipID(xi.slot.AMMO))

    if not damageRange then
        return 0, 0, 0
    end

    local pTable =
    {
        chance          = 22, -- TODO: this weapon has a lower base delay than tested gsword (Gust Tongue). Check proc rate
        basePower       = math.randomInt(damageRange[1], damageRange[2]),
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.WIND,
        canMAB          = false,
        canResist       = true,
        lowestResist    = 0.5,
        useAmmo         = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
