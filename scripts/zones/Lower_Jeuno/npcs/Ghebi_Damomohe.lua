-----------------------------------
-- Area: Lower Jeuno
--  NPC: Ghebi Damomohe
-- Starts and Finishes Quest: Tenshodo Membership
-- !pos 16 0 -5 245
-- TODO Enum shop items
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 106 and option == 0 then
        local stock =
        {
            4405,  144, -- Rice Ball
            4457, 2700, -- Eel Kabob
            4467,    3, -- Garlic Cracker
        }

        xi.shop.general(player, stock, xi.fameArea.NORG)
    end
end

return entity
