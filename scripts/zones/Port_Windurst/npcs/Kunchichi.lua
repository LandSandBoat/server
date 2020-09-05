-----------------------------------
-- Area: Port Windurst
--  NPC: Kunchichi
-- Type: Standard NPC
-- !pos -115.933 -4.25 109.533 240
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/magic")
-----------------------------------

function onSpawn(npc)
    npcUtil.castingAnimation(npc, tpz.magic.spellGroup.BLACK, 16)
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatWindurst, 15) == false then
        player:startEvent(623)
    else
        player:startEvent(228)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 623) then
        player:setMaskBit(player:getCharVar("WildcatWindurst"), "WildcatWindurst", 15, true)
    end
end
