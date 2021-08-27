-----------------------------------
-- Area: Sauromugue Champaign
--  NPC: qm2 (???) (Tower 2)
-- Involved in Quest: THF AF "As Thick As Thieves"
-- !pos 196.830 31.300 206.078 120
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------
local entity = {}

local function isNaked(player)
    for i = xi.slot.MAIN, xi.slot.BACK do
        if player:getEquipID(i) ~= 0 then return false end
    end
    return true
end

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.AS_THICK_AS_THIEVES) == QUEST_ACCEPTED and not player:hasKeyItem(xi.ki.FIRST_SIGNED_FORGED_ENVELOPE) and npcUtil.tradeHas(trade, 17474) then
        if isNaked(player) then
            player:startEvent(2) -- complete grappling part of the quest
        else
            player:messageSpecial(ID.text.THF_AF_WALL_OFFSET + 2, 0, 17474) -- You try climbing the wall using the [Grapnel], but you are too heavy.
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.AS_THICK_AS_THIEVES) == QUEST_ACCEPTED then
        if not player:hasKeyItem(xi.ki.FIRST_SIGNED_FORGED_ENVELOPE) then
            if npc:getLocalVar("[QM]Select") == 1 and npcUtil.popFromQM(player, npc, ID.mob.CLIMBPIX_HIGHRISE, {radius = 1, hide = 0}) then
                player:messageSpecial(ID.text.THF_AF_MOB)
            end
            player:messageSpecial(ID.text.THF_AF_WALL_OFFSET) -- It is impossible to climb this wall with your bare hands.
        else
            player:messageSpecial(ID.text.THF_AF_WALL_OFFSET + 1) -- There is no longer any need to climb the tower.
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 2 then
        player:delKeyItem(xi.ki.FIRST_FORGED_ENVELOPE)
        npcUtil.giveKeyItem(player, xi.ki.FIRST_SIGNED_FORGED_ENVELOPE)
        player:confirmTrade()
    end
end

return entity
