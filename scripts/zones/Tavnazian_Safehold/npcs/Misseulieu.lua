-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Misseulieu
-----------------------------------
local ID = zones[xi.zone.TAVNAZIAN_SAFEHOLD]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        12577, 2485, -- Brass Harness
        12985, 1625, -- Holly Clogs
    }

    if player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.SHELTERING_DOUBT then
        stock =
        {
            14317, 101055,  -- Barone Cosciales
            15305, 630255,  -- Barone Gambieras
            14848, 181905,  -- Barone Manopolas
            12577, 2485,    -- Brass Harness
            12985, 1625,    -- Holly Clogs
            15389, 8000000, -- Vir Subligar
            15390, 8000000, -- Femina Subligar

        }
    end

    player:showText(npc, ID.text.MISSEULIEU_SHOP_DIALOG) -- 10912 at least with 2 items available
    xi.shop.general(player, stock)
end

return entity
