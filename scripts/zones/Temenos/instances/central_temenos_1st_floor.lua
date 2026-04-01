-----------------------------------
-- Area: Temenos
-- Name: Central Temenos 1st Floor
-- !additem emerald_chip
-- !addkeyitem white_card
-- !addkeyitem cosmo_cleanse
-- !pos 580.000 -2.375 104.000 37
-----------------------------------
local ID = zones[xi.zone.TEMENOS]
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.TEMENOS,
    battlefieldId    = xi.battlefield.id.CENTRAL_TEMENOS_1ST_FLOOR,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(45),
    index            = 6,
    area             = 7,
    entryNpc         = 'Matter_Diffusion_Module',
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, xi.ki.WHITE_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    requiredItems    = { xi.item.EMERALD_CHIP },
    name             = 'CENTRAL_TEMENOS_1ST_FLOOR',
    lootCrateId      = ID.npc.C1_LOOT_CRATE,
})

function content:handleMobPartnerDeath(mobs, battlefield, mob, count)
    if count > 1 then
        return
    end

    local zone   = mob:getZone()
    local target = zone:queryEntitiesByName(mobs[1])[1]

    if target and mob:getID() == target:getID() then
        target = zone:queryEntitiesByName(mobs[2])[1]
    end

    target:timer(15000, function(mobArg)
        if target:isAlive() then
            target:injectActionPacket(target:getID(), 11, 439, 0, 24, 0, 307, 0)
            target:addMod(xi.mod.REGAIN, 150)
        end
    end)
end

content.groups =
{
    {
        mobs  = { 'Airi', 'Temenos_Cleaner' },
        death = utils.bind(content.handleMobPartnerDeath, content, { 'Airi', 'Temenos_Cleaner' }),
    },

    {
        mobs  = { 'Iruci', 'Temenos_Weapon' },
        death = utils.bind(content.handleMobPartnerDeath, content, { 'Iruci', 'Temenos_Weapon' }),
    },

    {
        mobs  = { 'Enhanced_Dragon', 'Enhanced_Ahriman' },
        death = utils.bind(content.handleMobPartnerDeath, content, { 'Enhanced_Dragon', 'Enhanced_Ahriman' }),
    },

    {
        mobs =
        {
            'Airi',
            'Temenos_Cleaner',
            'Iruci',
            'Temenos_Weapon',
            'Enhanced_Dragon',
            'Enhanced_Ahriman',
        },

        mods     = { [xi.mod.REGEN] = 24 },
        allDeath = function(battlefield, mob)
            xi.limbus.spawnFrom(mob, ID.npc.C1_LOOT_CRATE)
        end
    }
}

content.loot =
{
    [ID.npc.C1_LOOT_CRATE] =
    {
        {
            quantity = 6,
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.SQUARE_OF_BENEDICT_SILK, weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_DIABOLIC_SILK, weight = xi.loot.weight.NORMAL },
            { item = xi.item.SPOOL_OF_CHAMELEON_YARN, weight = xi.loot.weight.NORMAL },
            { item = xi.item.PANTIN_WIRE,             weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.SPOOL_OF_RUBY_SILK_THREAD, weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_SUPPLE_SKIN,     weight = xi.loot.weight.NORMAL },
            { item = xi.item.SPOOL_OF_GLITTERING_YARN,  weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_BRILLIANTINE,    weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,                     weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.SQUARE_OF_ECARLATE_CLOTH, weight = xi.loot.weight.LOW       },
            { item = xi.item.CHUNK_OF_SNOWY_CERMET,    weight = xi.loot.weight.LOW       },
            { item = xi.item.SQUARE_OF_SMALT_LEATHER,  weight = xi.loot.weight.LOW       },
            { item = xi.item.SQUARE_OF_FILET_LACE,     weight = xi.loot.weight.LOW       },
        },

        {
            { item = xi.item.ORCHID_CHIP, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,       weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.METAL_CHIP, weight = xi.loot.weight.VERY_LOW  },
        },
    }
}

return content:register()
