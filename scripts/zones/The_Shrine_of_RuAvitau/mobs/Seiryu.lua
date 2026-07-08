-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Seiryu (Pet version)
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.CANNOT_GUARD, 1)
    mob:setMod(xi.mod.REGAIN, 450)

    mob:addListener('EFFECT_LOSE', 'SEIRYU_HF', function(mobArg, effect)
        if effect:getEffectType() == xi.effect.HUNDRED_FISTS then
            mobArg:setMagicCastingEnabled(true)
            mobArg:setMobAbilityEnabled(true)
        end
    end)
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

entity.onMobWeaponSkill = function(mob, target, skill, action)
    if skill:getID() == xi.mobSkill.HUNDRED_FISTS_1 then
        mob:setMagicCastingEnabled(false)
        mob:setMobAbilityEnabled(false)
    end
end

return entity
