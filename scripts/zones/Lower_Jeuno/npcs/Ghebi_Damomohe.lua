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
            { xi.item.RICE_BALL,       168 },
            { xi.item.EEL_KABOB,      3150 },
            { xi.item.GARLIC_CRACKER,    4 },
        }

        xi.shop.general(player, stock, xi.fameArea.NORG)
    end
end

return entity
