-----------------------------------
-- Area: Ifrit's Cauldron
--   NM: Bomb Bastard
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.GIL_BONUS, -100)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:setMod(xi.mod.STUN_MEVA, 50)
    mob:addImmunity(xi.immunity.STUN)
end

entity.onMobFight = function(mob, target)
    if mob:getBattleTime() > 10 then
        mob:useMobAbility(511)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
