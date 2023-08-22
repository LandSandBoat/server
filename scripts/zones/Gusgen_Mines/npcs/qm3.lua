-----------------------------------
-- Area: Gusgen Mines
--  NPC: qm3 (???)
-- Involved In Quest: Healing the Land
-- !pos -168 1 311 196
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Gusgen_Mines/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local healingTheLand = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.HEALING_THE_LAND)

    if
        healingTheLand == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.SEAL_OF_BANISHING)
    then
        player:delKeyItem(xi.ki.SEAL_OF_BANISHING)
        player:messageSpecial(ID.text.FOUND_LOCATION_SEAL, xi.ki.SEAL_OF_BANISHING)
    elseif
        healingTheLand == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.SEAL_OF_BANISHING)
    then
        player:messageSpecial(ID.text.IS_ON_THIS_SEAL, xi.ki.SEAL_OF_BANISHING)
    else
        player:messageSpecial(ID.text.LETTERS_IS_WRITTEN_HERE)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
