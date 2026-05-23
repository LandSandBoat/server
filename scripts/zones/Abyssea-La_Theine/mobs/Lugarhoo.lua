-----------------------------------
-- Area: Abyssea - La Theine
--  Mob: Lugarhoo
-- Involved in Quest: An Eye for Revenge
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if
        player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.AN_EYE_FOR_REVENGE) == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.LUGARHOOS_EYEBALL)
    then
        player:addKeyItem(xi.ki.LUGARHOOS_EYEBALL)
    end
end

return entity
