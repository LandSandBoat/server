-----------------------------------
-- Area: Horlais Peak
--  Mob: Gerjis
-- BCNM: Eye of the Tiger
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 8)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 8)
    mob:setMod(xi.mod.SLOW_RES_RANK, 8)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 8)
    mob:setMod(xi.mod.BLIND_RES_RANK, 8)
    mob:setMod(xi.mod.REGAIN, 100)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobMobskillChoose = function(mob, target)
    local skills =
    {
        xi.mobSkill.GERJIS_GRIP,
        xi.mobSkill.CROSSTHRASH_1,
        xi.mobSkill.ROAR_1,
        xi.mobSkill.RAZOR_FANG_1,
    }

    return skills[math.random(1, #skills)]
end

return entity
