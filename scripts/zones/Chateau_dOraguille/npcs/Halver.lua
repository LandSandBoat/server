-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Halver
-- Involved in Mission 2-3, 3-3, 5-1, 5-2, 8-1
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos 2 0.1 0.1 233
-----------------------------------
local ID = zones[xi.zone.CHATEAU_DORAGUILLE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()
    local wildcatSandy = player:getCharVar('WildcatSandy')

    -- Lure of the Wildcat San d'Oria
    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 16)
    then
        player:startEvent(558)
    -- Blackmail quest
    elseif
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.BLACKMAIL) == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.SUSPICIOUS_ENVELOPE)
    then
        player:startEvent(549)
        player:setCharVar('BlackMailQuest', 1)
        player:delKeyItem(xi.ki.SUSPICIOUS_ENVELOPE)
    elseif pNation == xi.nation.SANDORIA then
        -- Rank 10 default dialogue
        if player:getRank(player:getNation()) == 10 then
            player:startEvent(31)
        -- Default dialogue
        else
            player:startEvent(577)
        end
    elseif pNation == xi.nation.BASTOK then
        player:showText(npc, ID.text.HALVER_OFFSET + 1092)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 558 then
        player:setCharVar('WildcatSandy', utils.mask.setBit(player:getCharVar('WildcatSandy'), 16, true))
    end
end

return entity
