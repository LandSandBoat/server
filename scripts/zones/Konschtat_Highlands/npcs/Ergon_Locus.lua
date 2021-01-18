-----------------------------------
-- Area: Konschtat Highlands
--  NPC: Ergon Locus ???
-- Involved in quest Dances with Luopans
-- pos 220.041 24.451 309.234
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- DANCES WITH LUOPANS
    if player:getQuestStatus(tpz.quest.log_id.ADOULIN, tpz.quest.id.adoulin.DANCES_WITH_LUOPANS) == QUEST_ACCEPTED and player:getNation() == tpz.nation.BASTOK then
        if not player:hasKeyItem(tpz.ki.FISTFUL_OF_HOMELAND_SOIL) and not player:hasKeyItem(tpz.ki.LUOPAN) then
            npcUtil.giveKeyItem(player, tpz.ki.FISTFUL_OF_HOMELAND_SOIL)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end


return entity
