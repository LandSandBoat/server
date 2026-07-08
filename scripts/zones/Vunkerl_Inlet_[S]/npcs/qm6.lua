-----------------------------------
-- Area: Vunkerl_Inlet_[S]
--  NPC: qm6 (???)
-- Involved In Quest: EVIL_AT_THE_INLET
-- !pos -636 -51 -454 83
-----------------------------------
local ID = zones[xi.zone.VUNKERL_INLET_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.EVIL_AT_THE_INLET) == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.EVIL_WARDING_SEAL)
    then
        player:startEvent(112)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 112 then
        player:delKeyItem(xi.ki.EVIL_WARDING_SEAL)
    end
end

return entity
