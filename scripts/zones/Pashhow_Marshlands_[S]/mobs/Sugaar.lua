-----------------------------------
-- Area: Pashhow Marshlands [S]
--   NM: Sugaar
-----------------------------------
mixins = { require('scripts/mixins/families/peiste') }
-----------------------------------
local ID = zones[xi.zone.PASHHOW_MARSHLANDS_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -416.496, y =  24.110, z = -441.589 }
}

entity.phList =
{
    [ID.mob.SUGAAR - 5] = ID.mob.SUGAAR, -- -412.599 24.437 -431.639
    [ID.mob.SUGAAR - 4] = ID.mob.SUGAAR, -- -455.311 24.499 -472.247
    [ID.mob.SUGAAR - 3] = ID.mob.SUGAAR, -- -446.738 24.499 -443.850
    [ID.mob.SUGAAR - 2] = ID.mob.SUGAAR, -- -417.691 23.840 -485.922
    [ID.mob.SUGAAR - 1] = ID.mob.SUGAAR, -- -444.380 24.499 -487.828
}

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

entity.onMobMobskillChoose = function(mob, target)
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
