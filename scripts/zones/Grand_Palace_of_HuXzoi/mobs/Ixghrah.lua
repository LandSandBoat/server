-----------------------------------
-- Area: Grand Palace of HuXzoi
--  Mob: Ix'ghrah
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    if (mob:getMod(xi.mod.SLASHRES)) then mob:setMod(xi.mod.SLASHRES, 1000); end
    if (mob:getMod(xi.mod.PIERCERES)) then mob:setMod(xi.mod.PIERCERES, 1000); end
    if (mob:getMod(xi.mod.IMPACTRES)) then mob:setMod(xi.mod.IMPACTRES, 1000); end
    if (mob:getMod(xi.mod.HTHRES)) then mob:setMod(xi.mod.HTHRES, 1000); end
end

entity.onMobFight = function(mob, target)
    local changeTime = mob:getLocalVar("changeTime")

    if (mob:getBattleTime() - changeTime > 60) then
        mob:setAnimationSub(math.random(0, 3))
        mob:setLocalVar("changeTime", mob:getBattleTime())
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    if (player:getCurrentMission(COP) == xi.mission.id.cop.A_FATE_DECIDED  and player:getCharVar("PromathiaStatus")==1) then
        player:setCharVar("PromathiaStatus", 2)
    end
end

return entity
