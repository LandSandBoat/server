-----------------------------------
-- Area: Sauromugue Champaign
--  NPC: qm7 (???) (Tower 7)
-- Involved in Quest: THF AF "As Thick As Thieves"
-- !pos -193.869 15.400 276.837 120
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.AS_THICK_AS_THIEVES) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 17474) then
        player:messageSpecial(ID.text.THF_AF_WALL_OFFSET + 3, 0, 17474) -- You cannot get a decent grip on the wall using the [Grapnel].
    end
end

function onTrigger(player, npc)
    if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.AS_THICK_AS_THIEVES) == QUEST_ACCEPTED then
        if not player:hasKeyItem(tpz.ki.FIRST_SIGNED_FORGED_ENVELOPE) then
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

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
