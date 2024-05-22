-----------------------------------
-- Area: Pashhow Marshlands [S]
--   NM: Sugaar
-----------------------------------
mixins = { require('scripts/mixins/families/peiste') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)

    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SILENCE, { chance = 15, duration = 30 })
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    -- seems overly complicated, but is reusable code for other mobs that use skills in a sequence
    local mobskillList =
    {
        2155, -- torpefying_charge
        2156, -- grim_glower
    }

    mob:setLocalVar('nextSkill', (mob:getLocalVar('nextSkill') + 1) % #mobskillList)
    local nextSkill = mob:getLocalVar('nextSkill') + 1
    return mobskillList[nextSkill]
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 508)
end

return entity
