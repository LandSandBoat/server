-----------------------------------
-- Area: Misareaux Coast
--  Mob: Boggelmann
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobMobskillChoose = function(mob, target)
    local tpMoves =
    {
        xi.mobSkill.AWFUL_EYE,
        xi.mobSkill.BONE_CRUNCH,
        xi.mobSkill.HEAVY_BELLOW,
        xi.mobSkill.HUNGRY_CRUNCH,
        xi.mobSkill.TAIL_ROLL,
        xi.mobSkill.TUSK,
        xi.mobSkill.SCUTUM
    }

    return tpMoves[math.random(1, #tpMoves)]
end

return entity
