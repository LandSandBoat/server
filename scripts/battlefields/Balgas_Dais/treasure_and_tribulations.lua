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
        npcUtil.showCrate(crate)
        crate:addListener('ON_TRIGGER', 'TRIGGER_CRATE', utils.bind(self.handleOpenArmouryCrate, self))
    end
end

content.groups =
{
    {
        mobs  = { 'Small_Box', 'Medium_Box', 'Large_Box', },
        death = utils.bind(content.handleCrateDefeated, content),
    },
}

content.loot =
{
    {
        { itemId = xi.item.GIL,                      weight = 10000, amount = 1734 }, -- TODO: Looks like gil that you get might behave like a regular treasure chest??
    },

    {
        { itemId = xi.item.GUARDIANS_RING,           weight =   625 },
        { itemId = xi.item.KAMPFER_RING,             weight =   625 },
        { itemId = xi.item.CONJURERS_RING,           weight =   625 },
        { itemId = xi.item.SHINOBI_RING,             weight =   625 },
        { itemId = xi.item.SLAYERS_RING,             weight =   625 },
        { itemId = xi.item.SORCERERS_RING,           weight =   625 },
        { itemId = xi.item.SOLDIERS_RING,            weight =   625 },
        { itemId = xi.item.TAMERS_RING,              weight =   625 },
        { itemId = xi.item.TRACKERS_RING,            weight =   625 },
        { itemId = xi.item.DRAKE_RING,               weight =   625 },
        { itemId = xi.item.FENCERS_RING,             weight =   625 },
        { itemId = xi.item.MINSTRELS_RING,           weight =   625 },
        { itemId = xi.item.MEDICINE_RING,            weight =   625 },
        { itemId = xi.item.ROGUES_RING,              weight =   625 },
        { itemId = xi.item.RONIN_RING,               weight =   625 },
        { itemId = xi.item.PLATINUM_RING,            weight =   625 },
    },

    {
        { itemId = xi.item.ASTRAL_RING,              weight =  3500 },
        { itemId = xi.item.PLATINUM_RING,            weight =   250 },
        { itemId = xi.item.SCROLL_OF_QUAKE,          weight =   250 },
        { itemId = xi.item.RAM_SKIN,                 weight =   250 },
        { itemId = xi.item.RERAISER,                 weight =   250 },
        { itemId = xi.item.MYTHRIL_INGOT,            weight =   250 },
        { itemId = xi.item.LIGHT_SPIRIT_PACT,        weight =   250 },
        { itemId = xi.item.SCROLL_OF_FREEZE,         weight =   250 },
        { itemId = xi.item.SCROLL_OF_REGEN_III,      weight =   250 },
        { itemId = xi.item.SCROLL_OF_RAISE_II,       weight =   250 },
        { itemId = xi.item.PETRIFIED_LOG,            weight =   250 },
        { itemId = xi.item.CORAL_FRAGMENT,           weight =   250 },
        { itemId = xi.item.MAHOGANY_LOG,             weight =   250 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =   250 },
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,        weight =   250 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =   250 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight =   250 },
        { itemId = xi.item.GOLD_INGOT,               weight =   250 },
        { itemId = xi.item.DARKSTEEL_INGOT,          weight =   250 },
        { itemId = xi.item.PLATINUM_INGOT,           weight =   250 },
        { itemId = xi.item.EBONY_LOG,                weight =   250 },
        { itemId = xi.item.RAM_HORN,                 weight =   250 },
        { itemId = xi.item.DEMON_HORN,               weight =   250 },
        { itemId = xi.item.MANTICORE_HIDE,           weight =   250 },
        { itemId = xi.item.WYVERN_SKIN,              weight =   250 },
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =   250 },
    },
}

return content:register()
