-----------------------------------
-- Area: Rabao
--  NPC: Leodarion
-- Involved in Quest: True Will
-- !pos -50 8 41 247
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRUE_WILL) == xi.questStatus.QUEST_ACCEPTED then
        local trueWillCS = player:getCharVar('trueWillCS')

        if trueWillCS == 1 then
            player:startEvent(97)
        elseif trueWillCS == 2 and not player:hasKeyItem(xi.ki.LARGE_TRICK_BOX) then
            player:startEvent(98)
        elseif player:hasKeyItem(xi.ki.LARGE_TRICK_BOX) then
            player:startEvent(99)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 97 then
        player:delKeyItem(xi.ki.OLD_TRICK_BOX)
        player:setCharVar('trueWillCS', 2)
    elseif csid == 99 then
        if
            npcUtil.completeQuest(player, xi.questLog.OUTLANDS, xi.quest.id.outlands.TRUE_WILL, {
                item = 13782, -- Ninja Chainmail
                fame = 20,
                fameArea = xi.fameArea.NORG,
                title = xi.title.PARAGON_OF_NINJA_EXCELLENCE,
                var = 'trueWillCS'
            })
        then
            player:delKeyItem(xi.ki.LARGE_TRICK_BOX)
        end
    end
end

return entity
