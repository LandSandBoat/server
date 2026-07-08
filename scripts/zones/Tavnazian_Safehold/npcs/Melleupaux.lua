-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Melleupaux
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock = {}

    if player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.SHELTERING_DOUBT then
        stock =
        {
            { xi.item.DAGGER,      2030 },
            { xi.item.LONGSWORD,   9216 },
            { xi.item.RUSTY_BOLT,     4 },
            { xi.item.FALX,       37296 },
            { xi.item.VOULGE,     20762 },
        }
    else
        stock =
        {
            { xi.item.DAGGER,     2030 },
            { xi.item.LONGSWORD,  9216 },
            { xi.item.RUSTY_BOLT,    4 },
        }
    end

    player:showText(npc, zones[xi.zone.TAVNAZIAN_SAFEHOLD].text.MELLEUPAUX_SHOP_DIALOG) -- 10910 without ch4 complete, may change
    xi.shop.general(player, stock)
end

return entity
