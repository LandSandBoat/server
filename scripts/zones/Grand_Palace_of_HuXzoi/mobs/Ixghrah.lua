-----------------------------------
-- Area: Grand Palace of HuXzoi
--  Mob: Ix'ghrah
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    if (mob:getMod(tpz.mod.SLASHRES)) then mob:setMod(tpz.mod.SLASHRES, 1000); end
    if (mob:getMod(tpz.mod.PIERCERES)) then mob:setMod(tpz.mod.PIERCERES, 1000); end
    if (mob:getMod(tpz.mod.IMPACTRES)) then mob:setMod(tpz.mod.IMPACTRES, 1000); end
    if (mob:getMod(tpz.mod.HTHRES)) then mob:setMod(tpz.mod.HTHRES, 1000); end
end

entity.onMobFight = function(mob, target)
    local changeTime = mob:getLocalVar("changeTime")

    if (mob:getBattleTime() - changeTime > 60) then
        mob:setAnimationSub(math.random(0, 3))
        mob:setLocalVar("changeTime", mob:getBattleTime())
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.A_FATE_DECIDED  and player:getCharVar("PromathiaStatus")==1) then
        player:setCharVar("PromathiaStatus", 2)
    end
end

return entity
