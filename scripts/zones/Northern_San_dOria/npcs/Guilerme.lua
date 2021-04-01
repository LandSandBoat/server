-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Guillerme
--  Involved in Quest: Rosel the Armorer
-- !pos -4.500 0.000 99.000 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    -- "Rosel the Armorer" quest status var
    local RoselTheArmorer = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.ROSEL_THE_ARMORER)

    -- "Rosel the Armorer" - turn in reciept to prince
    if (RoselTheArmorer == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.RECEIPT_FOR_THE_PRINCE)) then
        player:startEvent(507)
    else
        player:showText(npc, ID.text.GUILERME_DIALOG)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    -- "Rosel the Armorer", give receipt to NPC:Guilerme
    if (csid == 507) then
        player:delKeyItem(xi.ki.RECEIPT_FOR_THE_PRINCE)
    end

end

return entity
