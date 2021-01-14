-----------------------------------
-- Area: Phomiuna Aqueducts
--  Mob: Minotaur
-----------------------------------
mixins = {require("scripts/mixins/fomor_hate")}
require("scripts/globals/missions")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setLocalVar("fomorHateAdj", -2)
end

entity.onMobDeath = function(mob, player, isKiller)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.DISTANT_BELIEFS and player:getCharVar("PromathiaStatus") == 0) then
        player:setCharVar("PromathiaStatus", 1)
    end
end

return entity
