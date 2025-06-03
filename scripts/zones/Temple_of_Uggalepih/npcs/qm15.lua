-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ???
-- Involved in Quest: Knight Stalker
-- !pos 58 1 -70 159
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local pet = player:getPet()
    if
        player:getCharVar('KnightStalker_Progress') == 4 and
        player:getCharVar('KnightStalker_Kill') == 0 and
        player:getMainJob() == xi.job.DRG and
        pet and
        pet:getPetID() == xi.petId.WYVERN and
        npcUtil.popFromQM(player, npc, { ID.mob.CLEUVARION_M_RESOAIX, ID.mob.ROMPAULION_S_CITALLE }, { hide = 0, claim = false })
    then
        player:messageSpecial(ID.text.SOME_SORT_OF_CEREMONY + 1) -- Your wyvern reacts violently to this spot!
    elseif player:getCharVar('KnightStalker_Kill') == 1 then
        player:startEvent(67)
    else
        player:messageSpecial(ID.text.SOME_SORT_OF_CEREMONY)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 67 and
        npcUtil.completeQuest(player, xi.questLog.SANDORIA, xi.quest.id.sandoria.KNIGHT_STALKER, { item = 12519, fame = 60, title = xi.title.PARAGON_OF_DRAGOON_EXCELLENCE, var = { 'KnightStalker_Kill', 'KnightStalker_Progress' } })
    then
        player:delKeyItem(xi.ki.CHALLENGE_TO_THE_ROYAL_KNIGHTS)
        player:setCharVar('KnightStalker_Option1', 1) -- Optional post-quest cutscenes.
        player:setCharVar('KnightStalker_Option2', 1)
    end
end

return entity
