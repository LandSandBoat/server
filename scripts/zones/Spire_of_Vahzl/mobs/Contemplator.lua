-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Contemplator
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
        xi.mobSkill.SHADOW_SPREAD,
        xi.mobSkill.TRINARY_ABSORPTION,
        xi.mobSkill.TRINARY_TAP,
    }

    if mob:getHPP() > 35 then
        table.insert(tpMoves, xi.mobSkill.EMPTY_CUTTER)
        table.insert(tpMoves, xi.mobSkill.NEGATIVE_WHIRL_1)
        table.insert(tpMoves, xi.mobSkill.STYGIAN_VAPOR)
        table.insert(tpMoves, xi.mobSkill.WINDS_OF_PROMYVION_1)
    end

    return tpMoves[math.random(#tpMoves)]
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() > 35 then
        mob:setMod(xi.mod.REGAIN, 0)
    else
        mob:setMod(xi.mod.REGAIN, 100)
    end
end

return entity
