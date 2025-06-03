-----------------------------------
-- Area: Yhoator Jungle
--  NPC: ??? (qm3)
-- Involved in Quest: True will
-- !pos 203 0.1 82 124
-----------------------------------
local ID = zones[xi.zone.YHOATOR_JUNGLE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRUE_WILL) == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.OLD_TRICK_BOX)
    then
        if player:getCharVar('trueWillKilledNM') > 0 then
            npcUtil.giveKeyItem(player, xi.ki.OLD_TRICK_BOX)
            player:setCharVar('trueWillKilledNM', 0)
        else
            npcUtil.popFromQM(player, npc, { ID.mob.KAPPA_AKUSO, ID.mob.KAPPA_BONZE, ID.mob.KAPPA_BIWA }, { hide = 0 })
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
