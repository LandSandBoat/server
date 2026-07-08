-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Resauchamet
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local kill = player:getCharVar('FOMOR_HATE')
    local n = 0

    if kill < 8 then
        n = 0
    elseif kill < 15 then
        n = 1
    elseif kill < 50 then
        n = 2
    elseif kill >= 50 then
        n = 3
    end

    player:startEvent(355, n)
end

return entity
