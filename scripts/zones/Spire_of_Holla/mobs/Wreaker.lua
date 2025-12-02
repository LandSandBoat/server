-----------------------------------
-- Area: Spire of Holla
--  Mob: Wreaker
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
    mob:setMod(xi.mod.STORETP, 155)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 15)
end

entity.onMobMobskillChoose = function(mob, target)
    local tpMoves =
    {
        xi.mobSkill.SHADOW_SPREAD,
        xi.mobSkill.TRINARY_ABSORPTION,
        xi.mobSkill.EMPTY_CUTTER,
    }

    if mob:getHPP() > 35 then
        table.insert(tpMoves, xi.mobSkill.NEGATIVE_WHIRL_1)
        table.insert(tpMoves, xi.mobSkill.STYGIAN_VAPOR)
        table.insert(tpMoves, xi.mobSkill.TRINARY_TAP)
        table.insert(tpMoves, xi.mobSkill.WINDS_OF_PROMYVION_1)
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
