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
        player:showText(npc, ID.text.RUILLONT_INITIAL_DIALOG + 2, 0, 0, 0, 0, true, false)
    else
        player:showText(npc, ID.text.RUILLONT_INITIAL_DIALOG + 1, 0, 0, 0, 0, true, false)
    end
end

return entity
