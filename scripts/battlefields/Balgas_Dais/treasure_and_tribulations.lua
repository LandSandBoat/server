-----------------------------------
-- Treasure and Tribulations
-- Balga's Dais BCNM50, Comet Orb
-- !additem 1177
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.TREASURE_AND_TRIBULATIONS,
    maxPlayers       = 6,
    levelCap         = 50,
    timeLimit        = utils.minutes(30),
    index            = 4,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.COMET_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
})

function content:handleCrateDefeated(battlefield, mob)
    local crateId = battlefield:getArmouryCrate()
    local crate   = GetNPCByID(crateId)

    if crate then
        crate:teleport(mob:getPos(), mob:getRotPos())
        npcUtil.showCrate(crate)
        crate:addListener('ON_TRIGGER', 'TRIGGER_CRATE', utils.bind(self.handleOpenArmouryCrate, self))
    end
end

content.groups =
{
    {
        mobs =
        {
            'Small_Box',
            'Medium_Box',
            'Large_Box',
        },

        death = utils.bind(content.handleCrateDefeated, content),
    },
}

content.loot =
{
    {
        { itemId = xi.item.GUARDIANS_RING, weight =  75 }, -- Guardians Ring
        { itemId = xi.item.KAMPFER_RING,   weight =  32 }, -- Kampfer Ring
        { itemId = xi.item.CONJURERS_RING, weight =  54 }, -- Conjurers Ring
        { itemId = xi.item.SHINOBI_RING,   weight =  32 }, -- Shinobi Ring
        { itemId = xi.item.SLAYERS_RING,   weight =  97 }, -- Slayers Ring
        { itemId = xi.item.SORCERERS_RING, weight =  75 }, -- Sorcerers Ring
        { itemId = xi.item.SOLDIERS_RING,  weight = 108 }, -- Soldiers Ring
        { itemId = xi.item.TAMERS_RING,    weight =  22 }, -- Tamers Ring
        { itemId = xi.item.TRACKERS_RING,  weight =  65 }, -- Trackers Ring
        { itemId = xi.item.DRAKE_RING,     weight =  32 }, -- Drake Ring
        { itemId = xi.item.FENCERS_RING,   weight =  32 }, -- Fencers Ring
        { itemId = xi.item.MINSTRELS_RING, weight =  86 }, -- Minstrels Ring
        { itemId = xi.item.MEDICINE_RING,  weight =  86 }, -- Medicine Ring
        { itemId = xi.item.ROGUES_RING,    weight =  75 }, -- Rogues Ring
        { itemId = xi.item.RONIN_RING,     weight =  11 }, -- Ronin Ring
        { itemId = xi.item.PLATINUM_RING,  weight =  32 }, -- Platinum Ring
    },

    {
        { itemId = xi.item.ASTRAL_RING,              weight = 376 }, -- Astral Ring
        { itemId = xi.item.PLATINUM_RING,            weight =  22 }, -- Platinum Ring
        { itemId = xi.item.SCROLL_OF_QUAKE,          weight =  65 }, -- Scroll Of Quake
        { itemId = xi.item.RAM_SKIN,                 weight =  10 }, -- Ram Skin
        { itemId = xi.item.RERAISER,                 weight =  11 }, -- Reraiser
        { itemId = xi.item.MYTHRIL_INGOT,            weight =  22 }, -- Mythril Ingot
        { itemId = xi.item.LIGHT_SPIRIT_PACT,        weight =  10 }, -- Light Spirit Pact
        { itemId = xi.item.SCROLL_OF_FREEZE,         weight =  32 }, -- Scroll Of Freeze
        { itemId = xi.item.SCROLL_OF_REGEN_III,      weight =  43 }, -- Scroll Of Regen Iii
        { itemId = xi.item.SCROLL_OF_RAISE_II,       weight =  32 }, -- Scroll Of Raise Ii
        { itemId = xi.item.PETRIFIED_LOG,            weight =  11 }, -- Petrified Log
        { itemId = xi.item.CORAL_FRAGMENT,           weight =  11 }, -- Coral Fragment
        { itemId = xi.item.MAHOGANY_LOG,             weight =  11 }, -- Mahogany Log
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =  43 }, -- Chunk Of Platinum Ore
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,        weight = 108 }, -- Chunk Of Gold Ore
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =  32 }, -- Chunk Of Darksteel Ore
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight =  65 }, -- Chunk Of Mythril Ore
        { itemId = xi.item.GOLD_INGOT,               weight =  10 }, -- Gold Ingot
        { itemId = xi.item.DARKSTEEL_INGOT,          weight =  11 }, -- Darksteel Ingot
        { itemId = xi.item.PLATINUM_INGOT,           weight =  11 }, -- Platinum Ingot
        { itemId = xi.item.EBONY_LOG,                weight =  11 }, -- Ebony Log
        { itemId = xi.item.RAM_HORN,                 weight =  11 }, -- Ram Horn
        { itemId = xi.item.DEMON_HORN,               weight =  11 }, -- Demon Horn
        { itemId = xi.item.MANTICORE_HIDE,           weight =   9 }, -- Manticore Hide
        { itemId = xi.item.WYVERN_SKIN,              weight =  11 }, -- Wyvern Skin
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  11 }, -- Handful Of Wyvern Scales
        },
}

return content:register()
