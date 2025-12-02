-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Kalamainu
-- BCNM: Petrifying Pair
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    -- We set these to handle them as BCNM mobs properly since this is inside Ghelsba Outpost.
    mob:setMobMod(xi.mobMod.GIL_MIN, 0)
    mob:setMobMod(xi.mobMod.GIL_MAX, 0)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
end

entity.onMobEngage = function(mob, target)
    mob:useMobAbility(xi.mobSkill.SECRETION_1)
end

entity.onMobMobskillChoose = function(mob, target)
    local mobskillTable =
    {
        [1] = { xi.mobSkill.TAIL_BLOW_1,         10 },
        [2] = { xi.mobSkill.FIREBALL_1,          10 },
        [3] = { xi.mobSkill.BRAIN_CRUSH_1,       10 },
        [4] = { xi.mobSkill.TAIL_BLOW_1,         10 },
        [5] = { xi.mobSkill.BALEFUL_GAZE_LIZARD, 30 },
        [6] = { xi.mobSkill.PLAGUE_BREATH_1,     10 },
        [7] = { xi.mobSkill.INFRASONICS_1,       10 },
        [8] = { xi.mobSkill.SECRETION_1,         10 },
    }
    local randomRoll = math.random(1, 100)
    local weightSum  = 0

    for i = 1, #mobskillTable do
        weightSum = weightSum + mobskillTable[i][2]
        if randomRoll <= weightSum then
            return mobskillTable[i][1]
        end
    end
end

return entity
