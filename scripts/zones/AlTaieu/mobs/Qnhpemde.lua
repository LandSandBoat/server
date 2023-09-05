-----------------------------------
-- Area: Al'Taieu
--  Mob: Qn'hpemde
-- Jailor of Love Pet version
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(6) -- Mouth Closed
end

entity.onMobFight = function(mob, target)
    local changeTime = mob:getLocalVar("changeTime")

    if mob:getAnimationSub() == 6 and mob:getBattleTime() - changeTime > 30 then
        mob:setAnimationSub(3) -- Mouth Open
        -- Double the mob weapon damage
        mob:setMobMod(xi.mobMod.WEAPON_BONUS, mob:getMainLvl())
        -- Boost all damage taken by 50%
        mob:setMod(xi.mod.UDMGPHYS, 5000)
        mob:setMod(xi.mod.UDMGRANGE, 5000)
        mob:setMod(xi.mod.UDMGMAGIC, 5000)
        mob:setMod(xi.mod.UDMGBREATH, 5000)
        mob:setLocalVar("changeTime", mob:getBattleTime())

    elseif mob:getAnimationSub() == 3 and mob:getBattleTime() - changeTime > 30 then
        mob:setAnimationSub(6) -- Mouth Closed
        mob:setMobMod(xi.mobMod.WEAPON_BONUS, 0)
        mob:setMod(xi.mod.UDMGPHYS, 0)
        mob:setMod(xi.mod.UDMGRANGE, 0)
        mob:setMod(xi.mod.UDMGMAGIC, 0)
        mob:setMod(xi.mod.UDMGBREATH, 0)
        mob:setLocalVar("changeTime", mob:getBattleTime())
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local jailerOfLove = GetMobByID(ID.mob.JAILER_OF_LOVE)
    local numHpemdeKilled = jailerOfLove:getLocalVar("JoL_Qn_hpemde_Killed")

    jailerOfLove:setLocalVar("JoL_Qn_hpemde_Killed", numHpemdeKilled + 1)
end

return entity
