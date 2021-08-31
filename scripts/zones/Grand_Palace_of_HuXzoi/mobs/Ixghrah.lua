-----------------------------------
-- Area: Grand Palace of HuXzoi
--  Mob: Ix'ghrah
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    if (mob:getMod(xi.mod.SLASH_SDT)) then mob:setMod(xi.mod.SLASH_SDT, 1000); end
    if (mob:getMod(xi.mod.PIERCE_SDT)) then mob:setMod(xi.mod.PIERCE_SDT, 1000); end
    if (mob:getMod(xi.mod.IMPACT_SDT)) then mob:setMod(xi.mod.IMPACT_SDT, 1000); end
    if (mob:getMod(xi.mod.HTH_SDT)) then mob:setMod(xi.mod.HTH_SDT, 1000); end
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
