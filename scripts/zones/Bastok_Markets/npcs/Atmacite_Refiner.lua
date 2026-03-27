-----------------------------------
-- Area: Bastok Markets
--  NPC: Atmacite Refiner
-- !pos -352.500 -10.514 -162.000 235
-----------------------------------
require('scripts/globals/voidwatch')
-----------------------------------
---@type TNpcEntity
local entity = {}

local csids =
{
    MAIN_MENU = 8,
    SHARED    = 24,
}

entity.onTrigger = function(player, npc)
    local cruor = player:getCurrency('cruor')
    local emergenceCount = xi.voidwatch.getEmergenceCount(player)
    local infused = xi.voidwatch.getInfusedAtmacites(player)
    local infused1 = infused[1] or 0
    local infused2 = infused[2] or 0
    local infused3 = infused[3] or 0

    printf('[VW_Refiner_Bastok] onTrigger: cruor=%d emergence=%d infused=[%d,%d,%d]',
        cruor, emergenceCount, infused1, infused2, infused3)

    player:startEvent(csids.MAIN_MENU, cruor, emergenceCount, infused1, infused2, infused3, 0, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
    printf('[VW_Refiner_Bastok] onEventUpdate: csid=%d option=%d (0x%08X)', csid, option, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    printf('[VW_Refiner_Bastok] onEventFinish: csid=%d option=%d (0x%08X)', csid, option, option)

    if option == 0 or option == 0xFFFFFFFF then
        return
    end

    local selection = bit.band(option, 0xFF)
    local subOption = bit.band(bit.rshift(option, 8), 0xFF)
    printf('[VW_Refiner_Bastok]   parsed: sel=%d sub=%d', selection, subOption)
end

return entity
