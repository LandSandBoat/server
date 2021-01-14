-----------------------------------
-- Area: Al'Taieu
--  Mob: Qn'hpemde
-- Jailor of Love Pet version
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setAnimationSub(6) -- Mouth Closed
end

entity.onMobFight = function(mob, target)
    local changeTime = mob:getLocalVar("changeTime")

    if (mob:getAnimationSub() == 6 and mob:getBattleTime() - changeTime > 30) then
        mob:setAnimationSub(3) -- Mouth Open
        mob:addMod(tpz.mod.ATTP, 100)
        mob:addMod(tpz.mod.DEFP, -50)
        mob:addMod(tpz.mod.DMGMAGIC, -50)
        mob:setLocalVar("changeTime", mob:getBattleTime())

    elseif (mob:getAnimationSub() == 3 and mob:getBattleTime() - changeTime > 30) then
        mob:setAnimationSub(6) -- Mouth Closed
        mob:addMod(tpz.mod.ATTP, -100)
        mob:addMod(tpz.mod.DEFP, 50)
        mob:addMod(tpz.mod.DMGMAGIC, 50)
        mob:setLocalVar("changeTime", mob:getBattleTime())
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    local JoL = GetMobByID(ID.mob.JAILER_OF_LOVE)
    local HPEMDES = JoL:getLocalVar("JoL_Qn_hpemde_Killed")
    JoL:setLocalVar("JoL_Qn_hpemde_Killed", HPEMDES+1)
end

return entity
