-----------------------------------
-- Area: Jugner Forest
--  NPC: Signpost
-- Involved in Quest: Grimy Signposts
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local info =
    {
        [0] = 4,
        [1] = 3,
        [2] = 2,
        [3] = 1,
    }
    local offset = npc:getID() - ID.npc.SIGNPOST[1]
    local data = info[offset]

    if data then
        player:startEvent(data)
    end
end

return entity
