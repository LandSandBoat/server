-----------------------------------
-- ID: 17988
-- Item: Spark Kris
-- Additional effect: lightning damage depending on ammo
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local damageRange = xi.additionalEffect.getConsumableAmmoItemDamageRange(xi.element.THUNDER, actor:getEquipID(xi.slot.AMMO))

    if not damageRange then
        return 0, 0, 0
    end

    local pTable =
    {
        chance          = 10, -- TODO: get data on Daggers. This rate is from h2h (hydro patas)
        basePower       = math.randomInt(damageRange[1], damageRange[2]),
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.THUNDER,
        canMAB          = false,
        canResist       = true,
        lowestResist    = 0.5,
        useAmmo         = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
