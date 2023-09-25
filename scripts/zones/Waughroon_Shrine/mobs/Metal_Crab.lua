-----------------------------------
-- Area: Waughroon Shrine
-- Mob: Metal Crab
-- BCNM: Crustacean Conundrum
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------
local dots =
    {
        xi.effect.DIA,
        xi.effect.POISON,
        xi.effect.BIO,
        xi.effect.REQUIEM,
        xi.effect.CHOKE,
        xi.effect.SHOCK,
        xi.effect.FROST,
    }
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    if VanadielDayOfTheWeek() == xi.day.WATERSDAY then
        mob:setMod(xi.mod.REGEN, 6, 3, 0)
    end
    mob:setLocalVar("DAMAGE_NULL", 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, { power = 30 })
end

entity.onMobFight = function(mob, target)
    local count = 0

    for _, v in pairs(dots) do
        if mob:hasStatusEffect(v) then
            count = count + 1
        end
    end

    mob:setMod(xi.mod.REGEN_DOWN, count)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
