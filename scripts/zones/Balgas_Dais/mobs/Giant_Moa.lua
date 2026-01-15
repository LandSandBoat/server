-----------------------------------
-- Area: Balgas Dais
-- Mob: Giant Moa
-- KSNM: Moa Constrictors
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 70)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 8)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 8)
end

-- Additional effect: TP Drain absorbs all of the targets current TP
entity.onAdditionalEffect = function(mob, target, damage)
    local targetTP = target:getTP()
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TP_DRAIN, { chance = 25, power = targetTP })
end

-- Uses Contagion Transfer(40%), Toxic Pick(30%), Baleful Gaze(15%), or Hammer Beak(15%)
local mobskillTable =
{
    [1] = { xi.mobSkill.HAMMER_BEAK,             15 },
    [2] = { xi.mobSkill.BALEFUL_GAZE_COCKATRICE, 15 },
    [3] = { xi.mobSkill.TOXIC_PICK,              30 },
    [4] = { xi.mobSkill.CONTAGION_TRANSFER,      40 },
}

entity.onMobMobskillChoose = function(mob, target)
    local randomRoll = math.random(1, 100)
    local weightSum  = 0
    for i = 1, #mobskillTable do
        weightSum = weightSum + mobskillTable[i][2]
        if randomRoll <= weightSum then
            return mobskillTable[i][1]
        end
    end
end

-- Follows up Contagion Transfer with Contamination to spread all negative ailments to nearby enemies
entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == xi.mobSkill.CONTAGION_TRANSFER then
        mob:useMobAbility(xi.mobSkill.CONTAMINATION)
    end
end

return entity
