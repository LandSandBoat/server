-----------------------------------
-- Area: The Boyahda Tree
--   NM: Agas
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDeath = function(mob, player, optParams)
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.SEARCHING_FOR_THE_RIGHT_WORDS) == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.MOONDROP)
    then
        player:setCharVar('Searching_AgasKilled', 1)
    end
end

return entity
