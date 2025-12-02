-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Procreator
-----------------------------------
mixins = { require('scripts/mixins/families/gorger_nm') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 10)
    mob:setMod(xi.mod.STORETP, 62)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 25)
end

entity.onMobMobskillChoose = function(mob, target)
    local tpMoves =
    {
        xi.mobSkill.SPIRIT_ABSORPTION_2,
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

    return tpMoves[math.random(1, #tpMoves)]
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() > 35 then
        mob:setMod(xi.mod.REGAIN, 0)
    else
        mob:setMod(xi.mod.REGAIN, 100)
    end

    if mob:getHPP() < 20 then
        local nextMob = GetMobByID(mob:getID() - 1) --Agonizer aggros at <20%
        if nextMob and not nextMob:isEngaged() then
            nextMob:updateEnmity(target)
        end
    end
end

return entity
