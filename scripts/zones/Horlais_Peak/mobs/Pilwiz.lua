-----------------------------------
-- Area: Horlais Peak
--  Mob: Pilwiz
-- BCNM: Carapace Combatants
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMod(xi.mod.SILENCE_MEVA, 75)
    mob:setMod(xi.mod.SLEEP_MEVA, 50)
end

entity.onMobMagicPrepare = function(mob, target, spellId)
    return xi.magic.spell.STONEGA_II
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
