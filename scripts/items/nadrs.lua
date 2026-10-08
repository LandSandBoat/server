-----------------------------------
-- ID: 17650
-- Item: Nadrs
-- Additional effect: poison
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

    local pTable =
    {
        chance       = 3.5 + utils.clamp(dStat / 2, 0, 21.5), -- 3.5% + 1% per 2 INT based on the data. Unknown if there are knees that may increase rate a bit
        effectId     = xi.effect.POISON,
        power        = 2,                   -- Tested in Brenner
        duration     = math.random(30, 60), -- TODO: needs more research
    }

    return xi.combat.action.executeAddEffectEnfeeblement(actor, target, pTable)
end

return itemObject
