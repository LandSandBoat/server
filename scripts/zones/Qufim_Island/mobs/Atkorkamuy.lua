-----------------------------------
-- Area: Qufim Island
--  Mob: Atkorkamuy
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 100,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.WIND,
        basePower      = math.floor(damage / 2),
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

entity.onMobFight = function(mob, target)
    -- Todo: verify it actually has STP at all, by checking tp gains on retail (could be different mechanism)
    mob:setMod(xi.mod.STORETP, 40 - (mob:getHPP() / (100 / 40)))
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 310)
end

return entity
