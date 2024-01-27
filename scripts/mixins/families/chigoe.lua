-- Chigoe family mixin

require('scripts/globals/mixins')

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
    xi.jobAbility.BOXSTEP,
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
        mob:setHP(0)
    end)

    chigoeMob:addListener('WEAPONSKILL_TAKE', 'CHIGOE_WEAPONSKILL_TAKE', function(mob, wsid)
        if wsid then
            mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
            mob:setHP(0)
        end
    end)

    chigoeMob:addListener('ABILITY_TAKE', 'CHIGOE_ABILITY_TAKE', function(mob, user, ability)
        if jobAbilities[ability:getID()] then
            mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
            mob:setHP(0)
        end
    end)
end

return g_mixins.families.chigoe
