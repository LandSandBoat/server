-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Reinwald
-- !pos -266.373 3.999 -536.712 70
-----------------------------------
---@type TNpcEntity
local entity = {}

local stock =
{
    { xi.item.SPEED_APPLE,    750 },
    { xi.item.STAMINA_APPLE,  750 },
    { xi.item.SHADOW_APPLE,   750 },
    { xi.item.PEPPER_BISCUIT, 750 },
    { xi.item.FIRE_BISCUIT,   750 },
}

entity.onTrigger = function(player, npc)
    player:messageText(npc, zones[xi.zone.CHOCOBO_CIRCUIT].text.WELCOME_ADVENTURER, true, 2)
    xi.shop.general(player, stock)
end

return entity
