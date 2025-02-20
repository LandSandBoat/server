-----------------------------------
-- Area: Port Windurst
--  NPC: Kunchichi
-- !pos -115.933 -4.25 109.533 240
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onSpawn = function(npc)
    npcUtil.castingAnimation(npc, xi.magic.spellGroup.BLACK, 16)
end

entity.onTrigger = function(player, npc)
    local wildcatWindurst = player:getCharVar('WildcatWindurst')

    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 15)
    then
        player:startEvent(623)
    else
        player:startEvent(228)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 623 then
        player:setCharVar('WildcatWindurst', utils.mask.setBit(player:getCharVar('WildcatWindurst'), 15, true))
    end
end

return entity
