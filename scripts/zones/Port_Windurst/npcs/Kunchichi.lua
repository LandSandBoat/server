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
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
    npcUtil.castingAnimation(npc, xi.magic.spellGroup.BLACK, 16)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local wildcatWindurst = player:getCharVar("WildcatWindurst")

    if
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 15)
    then
        player:startEvent(623)
    else
        player:startEvent(228)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 623 then
        player:setCharVar("WildcatWindurst", utils.mask.setBit(player:getCharVar("WildcatWindurst"), 15, true))
    end
end

return entity
