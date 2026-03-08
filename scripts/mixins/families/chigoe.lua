-----------------------------------
-- Chigoe family mixin
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local jobAbilities = set{
    xi.jobAbility.SHIELD_BASH,
    xi.jobAbility.JUMP,
    xi.jobAbility.HIGH_JUMP,
    xi.jobAbility.WEAPON_BASH,
    xi.jobAbility.CHI_BLAST,
    xi.jobAbility.TOMAHAWK,
    xi.jobAbility.ANGON,
    xi.jobAbility.QUICKSTEP,
    xi.jobAbility.BOX_STEP,
    xi.jobAbility.STUTTER_STEP,
    xi.jobAbility.FEATHER_STEP,
}

g_mixins.families.chigoe = function(chigoeMob)
    chigoeMob:addListener('SPAWN', 'CHIGOE_SPAWN', function(mob)
        mob:hideName(true)
        mob:setUntargetable(true)
    end)

    chigoeMob:addListener('ENGAGE', 'CHIGOE_ENGAGE', function(mob, target)
        mob:hideName(false)
        mob:setUntargetable(false)
    end)

    chigoeMob:addListener('DISENGAGE', 'CHIGOE_DISENGAGE', function(mob, target)
        mob:hideName(true)
        mob:setUntargetable(true)
    end)

    chigoeMob:addListener('CRITICAL_TAKE', 'CHIGOE_CRITICAL_TAKE', function(mob)
        mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
        mob:setMobMod(xi.mobMod.NO_DROPS, 1)
        mob:setHP(0)
    end)

    chigoeMob:addListener('WEAPONSKILL_TAKE', 'CHIGOE_WEAPONSKILL_TAKE', function(user, target, skill, tp, action)
        target:setMobMod(xi.mobMod.EXP_BONUS, -100)
        target:setMobMod(xi.mobMod.NO_DROPS, 1)
        target:setHP(0)
    end)

    chigoeMob:addListener('ABILITY_TAKE', 'CHIGOE_ABILITY_TAKE', function(user, target, skill, action)
        if not jobAbilities[skill:getID()] then
            return
        end

        target:setMobMod(xi.mobMod.EXP_BONUS, -100)
        target:setMobMod(xi.mobMod.NO_DROPS, 1)
        target:setHP(0)
    end)
end

return g_mixins.families.chigoe
