-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Gate: Chocobo Circuit
-----------------------------------
---@type TNpcEntity
local entity = {}

local destinations =
{
    [244] =
    {
        [1] = { -25.518, 1.999, -83.857, 0, xi.zone.SOUTHERN_SAN_DORIA },
    },
    [245] =
    {
        [1] = { 63.579, 0.000, -84.056, 160, xi.zone.BASTOK_MINES },
    },
    [246] =
    {
        [1] = { 115.045, -5.000, -135.125, 192, xi.zone.WINDURST_WOODS },
    },
    [247] =
    {
        [1] = {    0.000, 0.000,  -95.901, 192, xi.zone.RULUDE_GARDENS },
        [2] = {  -92.091, 0.000,  165.495,  40, xi.zone.UPPER_JEUNO    },
        [3] = { -109.163, 0.000, -176.367, 215, xi.zone.LOWER_JEUNO    },
        [4] = {   22.968, 0.000,    8.138,  64, xi.zone.PORT_JEUNO     },
    },
    [248] =
    {
        [1] = { -79.968, 0.000, 102.975, 64, xi.zone.AHT_URHGAN_WHITEGATE },
    },
}

entity.onTrigger = function(player, npc)
    player:startEvent(244 + npc:getID() - zones[xi.zone.CHOCOBO_CIRCUIT].npc.GATE_OFFSET)
end

entity.onEventFinish = function(player, csid, option, npc)
    local destination = destinations[csid] and destinations[csid][option]
    if destination then
        player:setPos(unpack(destination))
    end
end

return entity
