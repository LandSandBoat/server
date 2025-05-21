-----------------------------------
-- Area: Ordelles Caves
--  NPC: Ruillont
-- Involved in Mission: The Rescue Drill
-- !pos -70 1 607 193
-----------------------------------
local ID = zones[xi.zone.ORDELLES_CAVES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Ruillont Default Actions vary based on Nation
    if player:getNation() == xi.nation.SANDORIA then
        player:showText(npc, ID.text.RUILLONT_INITIAL_DIALOG + 2)
    else
        player:showText(npc, ID.text.RUILLONT_INITIAL_DIALOG + 1)
    end
end

return entity
