-----------------------------------
-- Rapid Raptors
-- Balga's Dais BCNM50, Comet Orb
-- !additem 1177
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.RAPID_RAPTORS,
    maxPlayers       = 3,
    levelCap         = 50,
    timeLimit        = utils.minutes(15),
    index            = 13,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.COMET_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Dromiceiomimus' })

content.loot =
{
    {
        { item = xi.item.RAPTOR_SKIN, weight = 1000 }, -- raptor_skin
    },

    {
        { item = xi.item.ADAMAN_INGOT, weight = 1000 }, -- adaman_ingot
    },

    {
        { item = xi.item.NONE,                    weight = 190 }, -- nothing
        { item = xi.item.SLY_GAUNTLETS,           weight = 110 }, -- sly_gauntlets
        { item = xi.item.SPIKED_FINGER_GAUNTLETS, weight = 120 }, -- spiked_finger_gauntlets
        { item = xi.item.RUSH_GLOVES,             weight = 140 }, -- rush_gloves
        { item = xi.item.RIVAL_RIBBON,            weight = 140 }, -- rival_ribbon
        { item = xi.item.MANA_CIRCLET,            weight = 150 }, -- mana_circlet
        { item = xi.item.IVORY_MITTS,             weight = 150 }, -- ivory_mitts
    },

    {
        { item = xi.item.NONE,             weight =  30 }, -- nothing
        { item = xi.item.STORM_GORGET,     weight = 100 }, -- storm_gorget
        { item = xi.item.INTELLECT_TORQUE, weight = 100 }, -- intellect_torque
        { item = xi.item.BENIGN_NECKLACE,  weight = 120 }, -- benign_necklace
        { item = xi.item.HEAVY_MANTLE,     weight = 130 }, -- heavy_mantle
        { item = xi.item.HATEFUL_COLLAR,   weight = 170 }, -- hateful_collar
        { item = xi.item.ESOTERIC_MANTLE,  weight = 170 }, -- esoteric_mantle
        { item = xi.item.TEMPLARS_MANTLE,  weight = 180 }, -- templars_mantle
    },

    {
        { item = xi.item.NONE,              weight = 230 }, -- nothing
        { item = xi.item.MYTHRIL_INGOT,     weight = 200 }, -- mythril_ingot
        { item = xi.item.CHUNK_OF_IRON_ORE, weight = 200 }, -- chunk_of_iron_ore
        { item = xi.item.PETRIFIED_LOG,     weight = 370 }, -- petrified_log
    },

    {
        { item = xi.item.NONE,     weight = 560 }, -- nothing
        { item = xi.item.RERAISER, weight = 440 }, -- reraiser
    },
}

return content:register()
