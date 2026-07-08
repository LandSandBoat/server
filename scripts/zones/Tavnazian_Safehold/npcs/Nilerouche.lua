-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Nilerouche
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock = {}

    if player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.SHELTERING_DOUBT then
        stock =
        {
            { xi.item.LUFAISE_FLY,              108 },
            { xi.item.CLOTHESPOLE,             2640 },
            { xi.item.ARROWWOOD_LOG,             20 },
            { xi.item.ELM_LOG,                 7800 },
            { xi.item.SCROLL_OF_BANISH_III,   66000 },
            { xi.item.SAFEHOLD_WAYSTONE,      10000 },
            { xi.item.SCROLL_OF_DISTRACT_II, 175827 },
            { xi.item.SCROLL_OF_FRAZZLE_II,  217000 },
        }
    else
        stock =
        {
            { xi.item.LUFAISE_FLY,              108 },
            { xi.item.CLOTHESPOLE,             2640 },
            { xi.item.ARROWWOOD_LOG,             20 },
            { xi.item.ELM_LOG,                 7800 },
            { xi.item.SAFEHOLD_WAYSTONE,      10000 },
            { xi.item.SCROLL_OF_DISTRACT_II, 175827 },
            { xi.item.SCROLL_OF_FRAZZLE_II,  217000 },
        }
    end

    player:showText(npc, zones[xi.zone.TAVNAZIAN_SAFEHOLD].text.NILEROUCHE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
