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
        { item = xi.item.GUARDIANS_RING, weight =  75 }, -- Guardians Ring
        { item = xi.item.KAMPFER_RING,   weight =  32 }, -- Kampfer Ring
        { item = xi.item.CONJURERS_RING, weight =  54 }, -- Conjurers Ring
        { item = xi.item.SHINOBI_RING,   weight =  32 }, -- Shinobi Ring
        { item = xi.item.SLAYERS_RING,   weight =  97 }, -- Slayers Ring
        { item = xi.item.SORCERERS_RING, weight =  75 }, -- Sorcerers Ring
        { item = xi.item.SOLDIERS_RING,  weight = 108 }, -- Soldiers Ring
        { item = xi.item.TAMERS_RING,    weight =  22 }, -- Tamers Ring
        { item = xi.item.TRACKERS_RING,  weight =  65 }, -- Trackers Ring
        { item = xi.item.DRAKE_RING,     weight =  32 }, -- Drake Ring
        { item = xi.item.FENCERS_RING,   weight =  32 }, -- Fencers Ring
        { item = xi.item.MINSTRELS_RING, weight =  86 }, -- Minstrels Ring
        { item = xi.item.MEDICINE_RING,  weight =  86 }, -- Medicine Ring
        { item = xi.item.ROGUES_RING,    weight =  75 }, -- Rogues Ring
        { item = xi.item.RONIN_RING,     weight =  11 }, -- Ronin Ring
        { item = xi.item.PLATINUM_RING,  weight =  32 }, -- Platinum Ring
    },

    {
        { item = xi.item.ASTRAL_RING,              weight = 376 }, -- Astral Ring
        { item = xi.item.PLATINUM_RING,            weight =  22 }, -- Platinum Ring
        { item = xi.item.SCROLL_OF_QUAKE,          weight =  65 }, -- Scroll Of Quake
        { item = xi.item.RAM_SKIN,                 weight =  10 }, -- Ram Skin
        { item = xi.item.RERAISER,                 weight =  11 }, -- Reraiser
        { item = xi.item.MYTHRIL_INGOT,            weight =  22 }, -- Mythril Ingot
        { item = xi.item.LIGHT_SPIRIT_PACT,        weight =  10 }, -- Light Spirit Pact
        { item = xi.item.SCROLL_OF_FREEZE,         weight =  32 }, -- Scroll Of Freeze
        { item = xi.item.SCROLL_OF_REGEN_III,      weight =  43 }, -- Scroll Of Regen Iii
        { item = xi.item.SCROLL_OF_RAISE_II,       weight =  32 }, -- Scroll Of Raise Ii
        { item = xi.item.PETRIFIED_LOG,            weight =  11 }, -- Petrified Log
        { item = xi.item.CORAL_FRAGMENT,           weight =  11 }, -- Coral Fragment
        { item = xi.item.MAHOGANY_LOG,             weight =  11 }, -- Mahogany Log
        { item = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =  43 }, -- Chunk Of Platinum Ore
        { item = xi.item.CHUNK_OF_GOLD_ORE,        weight = 108 }, -- Chunk Of Gold Ore
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =  32 }, -- Chunk Of Darksteel Ore
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight =  65 }, -- Chunk Of Mythril Ore
        { item = xi.item.GOLD_INGOT,               weight =  10 }, -- Gold Ingot
        { item = xi.item.DARKSTEEL_INGOT,          weight =  11 }, -- Darksteel Ingot
        { item = xi.item.PLATINUM_INGOT,           weight =  11 }, -- Platinum Ingot
        { item = xi.item.EBONY_LOG,                weight =  11 }, -- Ebony Log
        { item = xi.item.RAM_HORN,                 weight =  11 }, -- Ram Horn
        { item = xi.item.DEMON_HORN,               weight =  11 }, -- Demon Horn
        { item = xi.item.MANTICORE_HIDE,           weight =   9 }, -- Manticore Hide
        { item = xi.item.WYVERN_SKIN,              weight =  11 }, -- Wyvern Skin
        { item = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  11 }, -- Handful Of Wyvern Scales
        },
}

return content:register()
