-----------------------------------
-- Area: Spire of Dem
--  Mob: Ingester
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

local function canUseFission(mob) -- Checks to see how many pets Ingester has currently to determine if it can use Fission.
    local mobId = mob:getID()
    for petId = mobId + 1, mobId + 4 do
        local pet = GetMobByID(petId)
        if pet and not pet:isSpawned() then
            return true
        end
    end

    return false
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.REGAIN, 150)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    local skillList =
    {
        xi.mobSkill.QUADRATIC_CONTINUUM_2,
        xi.mobSkill.SPIRIT_ABSOPTION_2,
        xi.mobSkill.VANITY_DRIVE_2,
        xi.mobSkill.STYGIAN_FLATUS_1,
        xi.mobSkill.PROMYVION_BARRIER_2,
    }

    if
        math.random(1, 100) <= 20 and
        canUseFission(mob)
    then
        return xi.mobSkill.FISSION
    else
        return skillList[math.random(1, #skillList)]
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.MP_DRAIN, { chance = 100, power = math.random(1, 4) })
end

return entity
