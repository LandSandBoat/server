-----------------------------------
-- Area: Ifrit's Cauldron
--   NM: Tyrannic Tunnok
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { power = 50 })
end

entity.onMobFight = function(mob, target)
    -- Damage seems to greatly increase towards near-death HP, often dealing up to 500 points of damage with normal hits.
    local power = (100 - mob:getHPP()) * 2
    if mob:getMod(xi.mod.MAIN_DMG_RATING) ~= utils.clamp(power, 1, 2000) then
        mob:setMod(xi.mod.MAIN_DMG_RATING, utils.clamp(power, 1, 2000))
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 400)
end

return entity
