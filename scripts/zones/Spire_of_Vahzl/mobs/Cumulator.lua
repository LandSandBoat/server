-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Cumulator
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
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.STORETP, 62)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 25)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
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

entity.onMobFight = function(mob, target)
    if mob:getHPP() > 35 then
        mob:setMod(xi.mod.REGAIN, 0)
    else
        mob:setMod(xi.mod.REGAIN, 100)
    end

    if mob:getHPP() < 20 then
        local nextMob = GetMobByID(mob:getID() - 5) --Procreator aggros at <20%
        if nextMob and not nextMob:isEngaged() then
            nextMob:updateEnmity(target)
        end
    end
end

return entity
