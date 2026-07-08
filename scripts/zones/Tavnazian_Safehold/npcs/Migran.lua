-----------------------------------
-- Area: Tavnasian Safehold
--  NPC: Migran
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock = {}

    if player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.SHELTERING_DOUBT then
        stock =
        {
            { xi.item.BARONE_COSCIALES,  101055 },
            { xi.item.BARONE_GAMBIERAS,  630255 },
            { xi.item.BARONE_MANOPOLAS,  181905 },
            { xi.item.BRASS_HARNESS,       2485 },
            { xi.item.HOLLY_CLOGS,         1625 },
            { xi.item.VIR_SUBLIGAR,     8000000 },
            { xi.item.FEMINA_SUBLIGAR,  8000000 },
        }
    else
        stock =
        {
            { xi.item.BRASS_HARNESS, 2485 },
            { xi.item.HOLLY_CLOGS,   1625 },
        }
    end

    player:showText(npc, zones[xi.zone.TAVNAZIAN_SAFEHOLD].text.MIGRAN_SHOP_DIALOG) -- 10914 with 2 items available, may change
    xi.shop.general(player, stock)
end

return entity
