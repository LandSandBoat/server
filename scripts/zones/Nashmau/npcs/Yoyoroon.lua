-----------------------------------
-- Area: Nashmau
--  NPC: Yoyoroon
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.TENSION_SPRING,       4940 },
        { xi.item.LOUDSPEAKER,          4940 },
        { xi.item.ACCELERATOR,          4940 },
        { xi.item.ARMOR_PLATE,          4940 },
        { xi.item.STABILIZER,           4940 },
        { xi.item.MANA_JAMMER,          4940 },
        { xi.item.AUTO_REPAIR_KIT,      4940 },
        { xi.item.MANA_TANK,            4940 },
        { xi.item.INHIBITOR,            9925 },
        { xi.item.SPEEDLOADER,          9925 },
        { xi.item.MANA_BOOSTER,         9925 },
        { xi.item.SCOPE,                9925 },
        { xi.item.SHOCK_ABSORBER,       9925 },
        { xi.item.VOLT_GUN,             9925 },
        { xi.item.STEALTH_SCREEN,       9925 },
        { xi.item.DAMAGE_GAUGE,         9925 },
        { xi.item.MANA_CONSERVER,       9925 },
        { xi.item.STROBE,              19890 },
        { xi.item.FLAME_HOLDER,        19890 },
        { xi.item.ICE_MAKER,           19890 },
        { xi.item.PATTERN_READER,      19890 },
        { xi.item.REPLICATOR,          19890 },
        { xi.item.ANALYZER,            19890 },
        { xi.item.HEAT_SEEKER,         19890 },
        { xi.item.HEATSINK,            19890 },
        { xi.item.FLASHBULB,           19890 },
        { xi.item.MANA_CONVERTER,      19890 },
        { xi.item.TENSION_SPRING_II,   29640 },
        { xi.item.SCANNER,             29640 },
        { xi.item.LOUDSPEAKER_II,      29640 },
        { xi.item.ACCELERATOR_II,      29640 },
        { xi.item.ARMOR_PLATE_II,      29640 },
        { xi.item.STABILIZER_II,       29640 },
        { xi.item.MANA_JAMMER_II,      29640 },
        { xi.item.HAMMERMILL,          41496 },
        { xi.item.BARRIER_MODULE,      41496 },
        { xi.item.RESISTER,            41496 },
        { xi.item.AUTO_REPAIR_KIT_II,  41496 },
        { xi.item.ARCANIC_CELL,        41496 },
        { xi.item.MANA_TANK_II,        41496 },
        { xi.item.STROBE_II,           53352 },
        { xi.item.TENSION_SPRING_III,  65208 },
        { xi.item.LOUDSPEAKER_III,     65208 },
        { xi.item.AMPLIFIER,           65208 },
        { xi.item.ACCELERATOR_III,     65208 },
        { xi.item.SCOPE_II,            65208 },
        { xi.item.ARMOR_PLATE_III,     65208 },
        { xi.item.STABILIZER_III,      65208 },
        { xi.item.MANA_JAMMER_III,     65208 },
        { xi.item.INHIBITOR_II,        82992 },
        { xi.item.SPEEDLOADER_II,      82992 },
        { xi.item.REPEATER,            82992 },
        { xi.item.STEALTH_SCREEN_II,   82992 },
        { xi.item.ATTUNER,            118560 },
        { xi.item.HEAT_CAPACITOR,     118560 },
        { xi.item.TACTICAL_PROCESSOR, 118560 },
        { xi.item.POWER_COOLER,       118560 },
        { xi.item.DRUM_MAGAZINE,      118560 },
        { xi.item.BARRAGE_TURBINE,    118560 },
        { xi.item.EQUALIZER,          118560 },
        { xi.item.BARRIER_MODULE_II,  118560 },
        { xi.item.TARGET_MARKER,      118560 },
        { xi.item.GALVANIZER,         118560 },
        { xi.item.MANA_CHANNELER,     118560 },
        { xi.item.PERCOLATOR,         118560 },
        { xi.item.ERASER,             118560 },
        { xi.item.VIVI_VALVE,         118560 },
        { xi.item.SMOKE_SCREEN,       118560 },
        { xi.item.DISRUPTOR,          118560 },
    }

    player:showText(npc, zones[xi.zone.NASHMAU].text.YOYOROON_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
