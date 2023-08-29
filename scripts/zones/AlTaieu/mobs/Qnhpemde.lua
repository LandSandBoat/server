-----------------------------------
-- Area: Al'Taieu
--  Mob: Qn'hpemde
-- Jailor of Love Pet version
-----------------------------------
local ID = zones[xi.zone.ALTAIEU]
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(6) -- Mouth Closed
end

entity.onMobFight = function(mob, target)
    local changeTime = mob:getLocalVar('changeTime')

    if mob:getAnimationSub() == 6 and mob:getBattleTime() - changeTime > 30 then
        mob:setAnimationSub(3) -- Mouth Open
        mob:addMod(xi.mod.ATTP, 100)
        mob:addMod(xi.mod.DEFP, -50)
        mob:addMod(xi.mod.DMGMAGIC, -5000)
        mob:setLocalVar('changeTime', mob:getBattleTime())

    elseif mob:getAnimationSub() == 3 and mob:getBattleTime() - changeTime > 30 then
        mob:setAnimationSub(6) -- Mouth Closed
        mob:addMod(xi.mod.ATTP, -100)
        mob:addMod(xi.mod.DEFP, 50)
        mob:addMod(xi.mod.DMGMAGIC, 5000)
        mob:setLocalVar('changeTime', mob:getBattleTime())
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local jailerOfLove = GetMobByID(ID.mob.JAILER_OF_LOVE)
    local numHpemdeKilled = jailerOfLove:getLocalVar('JoL_Qn_hpemde_Killed')

    jailerOfLove:setLocalVar('JoL_Qn_hpemde_Killed', numHpemdeKilled + 1)
end

return entity
