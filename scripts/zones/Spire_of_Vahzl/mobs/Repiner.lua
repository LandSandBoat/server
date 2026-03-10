-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Repiner
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
        xi.mobSkill.CAROUSEL_1,
        xi.mobSkill.EMPTY_THRASH,
        xi.mobSkill.IMPALEMENT,
    }

    if mob:getHPP() > 35 then
        table.insert(tpMoves, xi.mobSkill.MATERIAL_FEND)
        table.insert(tpMoves, xi.mobSkill.MURK)
        table.insert(tpMoves, xi.mobSkill.PROMYVION_BRUME_2)
    end

    return tpMoves[math.random(#tpMoves)]
end

return entity
