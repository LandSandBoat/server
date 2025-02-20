-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Nilerouche
-----------------------------------
local ID = zones[xi.zone.TAVNAZIAN_SAFEHOLD]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        17005,   108,    -- Lufaise Fly
        17383,  2640,    -- Clothespole
        688,      20,    -- Arrowwood Log
        690,    7800,    -- Elm Log
        2871,  10000,    -- Safehold Waystone
        4913, 175827,    -- Scroll of Distract II
        4915, 217000,    -- Scroll of Frazzle II
    }

    if player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.SHELTERING_DOUBT then
        stock =
        {
            17005,   108,    -- Lufaise Fly
            17383,  2640,    -- Clothespole
            688,      20,    -- Arrowwood Log
            690,    7800,    -- Elm Log
            4638,  66000,    -- Banish III
            2871,  10000,    -- Safehold Waystone
            4913, 175827,    -- Scroll of Distract II
            4915, 217000,    -- Scroll of Frazzle II
        }
    end

    player:showText(npc, ID.text.NILEROUCHE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
