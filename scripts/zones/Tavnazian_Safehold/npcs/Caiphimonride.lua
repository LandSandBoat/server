-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Caiphimonride
-----------------------------------
local ID = zones[xi.zone.TAVNAZIAN_SAFEHOLD]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        16450, 2030, -- Dagger
        16566, 9216, -- Longsword
        17335,    4, -- Rusty Bolt
    }

    if player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.SHELTERING_DOUBT then
        stock =
        {
            16450,  2030,  -- Dagger
            16566,  9216,  -- Longsword
            17335,     4,  -- Rusty Bolt
            18375, 37296,  -- Falx
            18214, 20762,  -- Voulge
        }
    end

    player:showText(npc, ID.text.CAIPHIMONRIDE_SHOP_DIALOG) -- 10908 with only 3 items available, may change
    xi.shop.general(player, stock)
end

return entity
