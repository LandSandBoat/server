-----------------------------------
-- Area: Sealions Den
--   NM: Ultima
-----------------------------------
local oneToBeFeared = require("scripts/zones/Sealions_Den/helpers/One_to_be_Feared")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

local abilities = { 1259, 1260, 1269, 1270 }

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    if mob:getHPP() > 75 then
        local checker = math.random()
        if checker < 0.50 then
            return abilities[1]
        elseif checker < 0.75 then
            return abilities[3]
        else
            return abilities[4]
        end
    end

    if mob:getHPP() < 20 then
        -- does a specific order of moves in final phase
        local order = mob:getLocalVar("order")

        if order == 0 then
            mob:setLocalVar("order", 1)
            return abilities[4]
        elseif order == 1 then
            mob:setLocalVar("order", 2)
            return abilities[2]
        else
            mob:setLocalVar("order", 0)
            return abilities[2]
        end
    end

end

entity.onMobFight = function(mob, target)
    -- Gains regain at under 25% HP
    if
       mob:getHPP() < 25 and not
       mob:hasStatusEffect(xi.effect.REGAIN)
    then
        mob:addStatusEffect(xi.effect.REGAIN, 5, 3, 0)
        mob:getStatusEffect(xi.effect.REGAIN):setFlag(xi.effectFlag.DEATH)
    end

    if mob:getLocalVar("nuclearWaste") == 1 then
        -- after nuclear waste immediately uses a random element ability
        local ability = math.random(1262,1267)
        mob:useMobAbility(ability)
        mob:setLocalVar("nuclearWaste", 0)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE, {duration = 60})
end

entity.onMobDeath = function(mob, player, isKiller)
    oneToBeFeared.handleUltimaDeath(mob, player, isKiller)
end

return entity
