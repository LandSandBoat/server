-----------------------------------
-- Area: Sealions Den
--   NM: Ultima
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
end

entity.onMobFight = function(mob, target)
    -- Gains regain at under 25% HP
    if mob:getHPP() < 25 and not mob:hasStatusEffect(xi.effect.REGAIN) then
        mob:addStatusEffect(xi.effect.REGAIN, 5, 3, 0)
        mob:getStatusEffect(xi.effect.REGAIN):setFlag(xi.effectFlag.DEATH)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE, {duration = 60})
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.ULTIMA_UNDERTAKER)
    player:setLocalVar("[OTBF]cs", 0)
end

return entity
