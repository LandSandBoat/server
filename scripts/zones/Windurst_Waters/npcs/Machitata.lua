-----------------------------------
-- Area: Windurst Waters
--  NPC: Machitata
-- Involved in Quest: Hat in Hand
-- !pos 164.230 0.999 -25.400 238
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:hasKeyItem(xi.keyItem.NEW_MODEL_HAT) and
        not utils.mask.getBit(player:getCharVar('QuestHatInHand_var'), 0)
    then
        player:messageSpecial(ID.text.YOU_SHOW_OFF_THE, 0, xi.keyItem.NEW_MODEL_HAT)
        player:startEvent(58)
    else
        player:startEvent(984, player:getNation())
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 58 then
        player:setCharVar('QuestHatInHand_var', utils.mask.setBit(player:getCharVar('QuestHatInHand_var'), 0, true))
        player:incrementCharVar('QuestHatInHand_count', 1)
    elseif csid == 984 then
        xi.moghouse.visitNpcOnEventFinish(player, csid, option, npc)
    end
end

return entity
