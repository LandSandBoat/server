-----------------------------------
-- Area: Ifrit's Cauldron
--   NM: Bomb Princess
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_BONUS, -100)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMod(tpz.mod.STUNRES, 50)
end

entity.onMobFight = function(mob, target)
    if mob:getBattleTime() > 10 then
        mob:useMobAbility(511)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
