-----------------------------------
-- Area: Windurst Waters
--  NPC: Atmacite Refiner
-- Voidwatch NPC — infuse/remove/enrich atmacite, examine stratum abyssite, teleport
-- !pos -27.500 -5.396 225.500 238
-----------------------------------
require('scripts/globals/voidwatch')
-----------------------------------
---@type TNpcEntity
local entity = {}

local csids =
{
    MAIN_MENU = 1023,
}

entity.onTrigger = function(player, npc)
    local cruor = player:getCurrency('cruor')
    local emergenceCount = xi.voidwatch.getEmergenceCount(player)
    local infused = xi.voidwatch.getInfusedAtmacites(player)
    local infused1 = infused[1] or 0
    local infused2 = infused[2] or 0
    local infused3 = infused[3] or 0

    printf('[VW_Refiner] onTrigger: cruor=%d emergence=%d infused=[%d,%d,%d]',
        cruor, emergenceCount, infused1, infused2, infused3)

    player:startEvent(csids.MAIN_MENU, cruor, emergenceCount, infused1, infused2, infused3, 0, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
    printf('[VW_Refiner] onEventUpdate: csid=%d option=%d (0x%08X)', csid, option, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    printf('[VW_Refiner] onEventFinish: csid=%d option=%d (0x%08X)', csid, option, option)

    if option == 0 or option == 0xFFFFFFFF then
        return
    end

    local selection = bit.band(option, 0xFF)
    local subOption = bit.band(bit.rshift(option, 8), 0xFF)
    local param3 = bit.band(bit.rshift(option, 16), 0xFF)
    local param4 = bit.band(bit.rshift(option, 24), 0xFF)
    printf('[VW_Refiner]   parsed: sel=%d sub=%d p3=%d p4=%d', selection, subOption, param3, param4)
end

return entity
