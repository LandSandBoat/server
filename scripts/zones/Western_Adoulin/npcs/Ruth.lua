-----------------------------------
-- Area: Western Adoulin
--  NPC: Ruth
-- Involved With Quest: 'A Pioneers Best (Imaginary) Friend'
-- !pos -144 4 -10 256
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.SOA) >= xi.mission.id.soa.LIFE_ON_THE_FRONTIER then
        if
            player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.A_PIONEERS_BEST_IMAGINARY_FRIEND) == xi.questStatus.QUEST_ACCEPTED and
            not player:hasStatusEffect(xi.effect.IONIS)
        then
            -- Progresses Quest: 'A Pioneers Best (Imaginary) Friend'
            player:startEvent(2523)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 2523 then
        -- Progresses Quest: 'A Pioneers Best (Imaginary) Friend'
        player:delStatusEffectsByFlag(xi.effectFlag.INFLUENCE, true)
        player:addStatusEffect(xi.effect.IONIS, 0, 0, 9000)
    end
end

return entity
