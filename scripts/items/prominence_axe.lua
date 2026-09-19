-----------------------------------
-- ID: 18220
-- Item: Prominence Axe
-- Additional effect: fire damage
-- Enchantment: Enfire
-- Duration: 3 minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local pTable =
    {
        chance          = 7,
        basePower       = math.randomInt(3, 5),
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.FIRE,
        canMAB          = false,
        canResist       = true,
        lowestResist    = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

itemObject.onItemCheck = function(target, user)
    if target:getStatusEffectBySource(xi.effect.ENFIRE, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PROMINENCE_AXE) ~= nil then
        target:delStatusEffect(xi.effect.ENFIRE, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.PROMINENCE_AXE)
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.PROMINENCE_AXE) then
        local effect = xi.effect.ENFIRE
        local magicskill = target:getSkillLevel(xi.skill.ENHANCING_MAGIC)
        local potency = 0

        if magicskill <= 200 then
            potency = 3 + math.floor(6 * magicskill / 100)
        elseif magicskill > 200 then
            potency = 5 + math.floor(5 * magicskill / 100)
        end

        potency = utils.clamp(potency, 3, 25)

        target:addStatusEffect(effect, { power = potency, duration = 180, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.PROMINENCE_AXE })
    end
end


return itemObject
