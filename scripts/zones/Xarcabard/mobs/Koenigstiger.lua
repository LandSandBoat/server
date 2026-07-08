-----------------------------------
-- Area: Xarcabard
--  Mob: Koenigstiger
-- Involved in Quests: Unbridled Passion (RNG AF3)
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 240)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 300)
    mob:setMod(xi.mod.STORETP, 75) -- 8 hits to 1k tp
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    return xi.magic.spell.GRAVIGA
end

entity.onMobDeath = function(mob, player, optParams)
    if player:getCharVar('unbridledPassion') == 4 then
        player:setCharVar('unbridledPassion', 5)
    end
end

return entity
