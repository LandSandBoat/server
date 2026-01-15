-----------------------------------
-- ID: 19841
-- Item: Excalibur
-- Additional effect: Slashing Damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(attacker, defender, baseAttackDamage, item)
    if math.random(1, 100) <= 7 then -- 7% chance
        local params = {}

        params.subEffect  = xi.subEffect.LIGHT_DAMAGE
        params.damageType = xi.damageType.SLASHING
        params.isPhysical = true
        params.damage     = math.floor(attacker:getHP() * 0.25)

        return xi.additionalEffect.procFunctions[xi.additionalEffect.procType.PHYS_DAMAGE](attacker, defender, item, params)
    end

    return 0, 0, 0
end

return itemObject
