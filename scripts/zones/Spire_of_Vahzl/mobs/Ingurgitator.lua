-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Ingurgitator
-----------------------------------
mixins = { require('scripts/mixins/families/gorger_nm') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local tpMoves =
    {
        xi.mobSkill.SPIRIT_ABSORPTION_GORGER_2,
        xi.mobSkill.VANITY_DRIVE_2,
    }

    if mob:getHPP() > 35 then
        table.insert(tpMoves, xi.mobSkill.QUADRATIC_CONTINUUM_2)
        table.insert(tpMoves, xi.mobSkill.STYGIAN_FLATUS_1)
        table.insert(tpMoves, xi.mobSkill.PROMYVION_BARRIER_2)
    end

    if xi.mix.gorger.canUseFission(mob) then
        table.insert(tpMoves, xi.mobSkill.FISSION)
    end

    return tpMoves[math.random(#tpMoves)]
end

return entity
