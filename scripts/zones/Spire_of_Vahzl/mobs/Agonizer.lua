-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Agonizer
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

    if mob:getHPP() < 20 then
        local nextMob = GetMobByID(mob:getID() + 6) --Cumulator aggros at <20%
        if nextMob and not nextMob:isEngaged() then
            nextMob:updateEnmity(target)
        end
    end
end

return entity
