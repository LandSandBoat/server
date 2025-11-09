-----------------------------------
-- Area: Spire of Mea
--  Mob: Delver
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.DEFP, 35)
    mob:setMod(xi.mod.STORETP, 62)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 15)
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
