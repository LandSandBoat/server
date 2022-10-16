-----------------------------------
-- Area: Metalworks
--  NPC: Cid
-- !pos -12 -12 1 237
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- DARK PUPPET
    if
        player:getMainJob() == xi.job.DRK and
        player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL and
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_LEGACY) == QUEST_COMPLETED and
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_PUPPET) == QUEST_AVAILABLE
    then
        player:startEvent(760)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 760 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_PUPPET)
        player:setCharVar("darkPuppetCS", 1)
    end
end

return entity
