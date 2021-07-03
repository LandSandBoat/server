-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Mystic Retriever
-- Rov NPC
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/npc_util")
require("scripts/globals/items")
require("scripts/globals/spell_data")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- TODO: Verification if it gives the item only once
    if
        not player:hasItem(xi.items.CIPHER_OF_TENZENS_ALTER_EGO_II) and
        not player:hasSpell(xi.magic.spell.TENZEN_II) and
        player:hasCompletedMission(xi.mission.log_id.ROV, xi.mission.id.rov.CRASHING_WAVES)
    then
        npcUtil.giveItem(player, xi.items.CIPHER_OF_TENZENS_ALTER_EGO_II)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
