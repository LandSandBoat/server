-----------------------------------
-- Area: Maze of Shakhrami
--  NPC: qm2
-- Type: Quest NPC
-- !pos 143 9 -219 198
-----------------------------------
local ID = require("scripts/zones/Maze_of_Shakhrami/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if
        player:getQuestStatus(WINDURST, tpz.quest.id.windurst.ECO_WARRIOR) ~= QUEST_AVAILABLE and
        player:getCharVar("ECO_WARRIOR_ACTIVE") == 238 and
        player:hasStatusEffect(tpz.effect.LEVEL_RESTRICTION) and
        not player:hasKeyItem(tpz.ki.INDIGESTED_MEAT)
    then
        if player:getCharVar("ECO_WAR_WIN-NMs_killed") == 1 then
            npcUtil.giveKeyItem(player, tpz.ki.INDIGESTED_MEAT)
        elseif npcUtil.popFromQM(player, npc, {ID.mob.WYRMFLY_OFFSET, ID.mob.WYRMFLY_OFFSET + 1, ID.mob.WYRMFLY_OFFSET + 2}, {hide = 0}) then
            -- no further action
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
