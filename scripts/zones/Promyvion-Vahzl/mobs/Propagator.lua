-----------------------------------
-- Area: Promyvion - Vahzl
--   NM: Propagator
-----------------------------------
mixins =
{
    require('scripts/mixins/families/gorger_nm'),
    require('scripts/mixins/families/empty_terroanima'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 240)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local tpMoves =
    {
        xi.mobSkill.PROMYVION_BARRIER_2,
        xi.mobSkill.QUADRATIC_CONTINUUM_2,
        xi.mobSkill.SPIRIT_ABSORPTION_GORGER_2,
        xi.mobSkill.STYGIAN_FLATUS_1,
        xi.mobSkill.VANITY_DRIVE_2,
    }

    if xi.mix.gorger.canUseFission(mob) then
        table.insert(tpMoves, xi.mobSkill.FISSION)
    end

    return tpMoves[math.randomInt(1, #tpMoves)]
end

return entity
