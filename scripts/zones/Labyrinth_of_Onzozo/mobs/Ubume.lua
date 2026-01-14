-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Ubume
-- Involved in Quest: Yomi Okuri
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGPHYS, -5000)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
end

-- Average recast time on Horde Lullaby seems to be around 35-45 seconds.

entity.onMobSpellChoose = function(mob, target, spellId)
    return xi.magic.spell.HORDE_LULLABY
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
