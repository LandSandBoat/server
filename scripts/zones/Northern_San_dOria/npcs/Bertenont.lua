-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Bertenont
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -165 0.1 226 231
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatSandy = player:getCharVar('WildcatSandy')

    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 9)
    then
        player:startEvent(809)
    else
        player:showText(npc, ID.text.BERTENONT_DIALOG)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 809 then
        player:setCharVar('WildcatSandy', utils.mask.setBit(player:getCharVar('WildcatSandy'), 9, true))
    end
end

return entity
