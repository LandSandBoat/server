-----------------------------------
-- Area: Ranguemont Pass
--  NPC: Waters of Oblivion
-- Finish Quest: Painful Memory (BARD AF1)
-- !pos -284 -45 210 166
-----------------------------------
local ID = zones[xi.zone.RANGUEMONT_PASS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local trosKilled = player:getCharVar('TrosKilled')

    if
        player:hasKeyItem(xi.ki.MERTAIRES_BRACELET) and
        not GetMobByID(ID.mob.TROS):isSpawned() and
        (trosKilled == 0 or (os.time() - player:getCharVar('Tros_Timer')) > 60)
    then
        player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
        SpawnMob(ID.mob.TROS):updateClaim(player)
    elseif player:hasKeyItem(xi.ki.MERTAIRES_BRACELET) and trosKilled == 1 then
        player:startEvent(8) -- Finish Quest 'Painful Memory'
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 8 then
        if npcUtil.completeQuest(player, xi.questLog.JEUNO, xi.quest.id.jeuno.PAINFUL_MEMORY, { item = 16766 }) then
            player:delKeyItem(xi.ki.MERTAIRES_BRACELET)
            player:setCharVar('TrosKilled', 0)
            player:setCharVar('Tros_Timer', 0)
        end
    end
end

return entity
