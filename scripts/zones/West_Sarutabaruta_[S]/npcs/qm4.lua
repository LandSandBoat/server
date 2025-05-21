-----------------------------------
-- Area: West Sarutabaruta [S]
--  NPC: qm4
-- Note: Involved in quest "The Tigress Stirs"
-- !pos 150 -39 331 95
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STIRS) == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.SMALL_STARFRUIT)
    then
        npcUtil.giveKeyItem(player, xi.ki.SMALL_STARFRUIT)
    end
end

return entity
