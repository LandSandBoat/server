-----------------------------------
-- Area: Selbina
--  NPC: Mathilde
-- Involved in Quest: Riding on the Clouds
-- !pos 12.578 -8.287 -7.576 248
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Note: Event 173 is shown once on the first time when talking to Mathilde.  Followup event
    -- that repeats is event 174.
    -- TODO: Implement this as a unique event

    -- Former implementation defaulted to event 171, which was not observed.
end

return entity
