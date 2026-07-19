-----------------------------------
-- Area: Konschtat Highlands
--   NM: Forger
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
    mob:setMod(xi.mod.DMG, 7500)                         -- Takes x1.75 damage (all types).
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 175) -- Deals x1.75 melee damage.
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mobSkill.BERSERK_BOMB
end

return entity
