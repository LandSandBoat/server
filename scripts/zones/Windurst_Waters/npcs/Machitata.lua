-----------------------------------
-- Area: Windurst Waters
--  NPC: Machitata
-- Involved in Quest: Hat in Hand
-- !pos 163 0 -22 238
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:hasKeyItem(xi.ki.NEW_MODEL_HAT) and
        not utils.mask.getBit(player:getCharVar('QuestHatInHand_var'), 0)
    then
        player:messageSpecial(ID.text.YOU_SHOW_OFF_THE, 0, xi.ki.NEW_MODEL_HAT)
        player:startEvent(58)
    else
        player:startEvent(526)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 58 then
        player:setCharVar('QuestHatInHand_var', utils.mask.setBit(player:getCharVar('QuestHatInHand_var'), 0, true))
        player:incrementCharVar('QuestHatInHand_count', 1)
    end
end

return entity
