-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Femitte
-- Involved in Quest: Lure of the Wildcat (San d'Oria), Distant Loyalties
-- !pos -17 2 10 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/quests")
require("scripts/globals/utils")
require("scripts/globals/events/starlight_celebrations")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        if xi.events.starlightCelebration.npcGiftsNpcOnTrigger(player, 2) then
            return
        end
    end

    local wildcatSandy = player:getCharVar("WildcatSandy")

    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 3)
    then
        player:startEvent(807)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 807 then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 3, true))
    end
end

--------Other CS
--32692
--0
--661  Standard dialog
--663
--664
--665
--725
--747
--748
--807  Lure of the Wildcat
--945  CS with small mythra dancer

return entity
