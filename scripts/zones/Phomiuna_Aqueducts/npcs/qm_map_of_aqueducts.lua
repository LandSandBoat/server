-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: qm_map_of_aqueducts (???)
-- Note: respawns 30 min after someone acquires map, randomly at one of four locations
-- !pos 83.899 -24.963 32.047 27
-- !pos ? ? ? 27
-- !pos ? ? ? 27
-- !pos ? ? ? 27
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.MAP_OF_THE_AQUEDUCTS) then
        npcUtil.giveKeyItem(player, xi.ki.MAP_OF_THE_AQUEDUCTS)
        -- TODO: find other three locations, hide QM, respawn 30 minutes later at random location
    end
end

return entity
