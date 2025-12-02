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
        { itemId = xi.item.RAPTOR_SKIN, weight = 1000 }, -- raptor_skin
    },

    {
        { itemId = xi.item.ADAMAN_INGOT, weight = 1000 }, -- adaman_ingot
    },

    {
        { itemId = xi.item.NONE,                    weight = 190 }, -- nothing
        { itemId = xi.item.SLY_GAUNTLETS,           weight = 110 }, -- sly_gauntlets
        { itemId = xi.item.SPIKED_FINGER_GAUNTLETS, weight = 120 }, -- spiked_finger_gauntlets
        { itemId = xi.item.RUSH_GLOVES,             weight = 140 }, -- rush_gloves
        { itemId = xi.item.RIVAL_RIBBON,            weight = 140 }, -- rival_ribbon
        { itemId = xi.item.MANA_CIRCLET,            weight = 150 }, -- mana_circlet
        { itemId = xi.item.IVORY_MITTS,             weight = 150 }, -- ivory_mitts
    },

    {
        { itemId = xi.item.NONE,             weight =  30 }, -- nothing
        { itemId = xi.item.STORM_GORGET,     weight = 100 }, -- storm_gorget
        { itemId = xi.item.INTELLECT_TORQUE, weight = 100 }, -- intellect_torque
        { itemId = xi.item.BENIGN_NECKLACE,  weight = 120 }, -- benign_necklace
        { itemId = xi.item.HEAVY_MANTLE,     weight = 130 }, -- heavy_mantle
        { itemId = xi.item.HATEFUL_COLLAR,   weight = 170 }, -- hateful_collar
        { itemId = xi.item.ESOTERIC_MANTLE,  weight = 170 }, -- esoteric_mantle
        { itemId = xi.item.TEMPLARS_MANTLE,  weight = 180 }, -- templars_mantle
    },

    {
        { itemId = xi.item.NONE,              weight = 230 }, -- nothing
        { itemId = xi.item.MYTHRIL_INGOT,     weight = 200 }, -- mythril_ingot
        { itemId = xi.item.CHUNK_OF_IRON_ORE, weight = 200 }, -- chunk_of_iron_ore
        { itemId = xi.item.PETRIFIED_LOG,     weight = 370 }, -- petrified_log
    },

    {
        { itemId = xi.item.NONE,     weight = 560 }, -- nothing
        { itemId = xi.item.RERAISER, weight = 440 }, -- reraiser
    },
}

return content:register()
