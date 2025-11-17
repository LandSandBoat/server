-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47d
-- !pos 20.000 24.168 -25.000 151
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        not player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.ONION_RINGS) and
        not player:hasKeyItem(xi.ki.OLD_RING)
    then
        player:startCutscene(44, 0, xi.ki.OLD_RING)
    elseif npc:getAnimation() == xi.anim.CLOSE_DOOR then
        npc:openDoor()
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 44 then
        npcUtil.giveKeyItem(player, xi.ki.OLD_RING)
    end
end

return entity
