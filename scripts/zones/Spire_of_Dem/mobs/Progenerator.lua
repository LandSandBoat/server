-----------------------------------
-- Area: Spire of Dem
--  Mob: Progenerator
-----------------------------------
mixins =
{
    require('scripts/mixins/families/empty_terroanima'),
    require('scripts/mixins/families/gorger_nm'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DEFP, 35)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 10)
    mob:setMod(xi.mod.STORETP, 62)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 15)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
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
    if mob:getTP() >= 2000 then
        mob:useMobAbility()
    end

    if mob:getHPP() > 35 then
        mob:setMod(xi.mod.REGAIN, 0)
    else
        mob:setMod(xi.mod.REGAIN, 100)
    end
end

return entity
