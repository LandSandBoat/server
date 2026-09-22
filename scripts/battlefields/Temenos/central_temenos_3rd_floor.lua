-----------------------------------
-- Area: Temenos
-- Name: Central Temenos 3rrd Floor
-- !addkeyitem white_card
-- !addkeyitem cosmo_cleanse
-- !additem ivory_chip
-- !pos 580.000 -2.375 104.000 37
-----------------------------------
local ID = zones[xi.zone.TEMENOS]
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.TEMENOS,
    battlefieldId    = xi.battlefield.id.CENTRAL_TEMENOS_3RD_FLOOR,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(45),
    index            = 4,
    area             = 5,
    entryNpc         = 'Matter_Diffusion_Module',
    requiredKeyItems = { xi.keyItem.COSMO_CLEANSE, xi.keyItem.WHITE_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    requiredItems    = { xi.item.IVORY_CHIP },
    name             = 'CENTRAL_TEMENOS_3RD_FLOOR',
    lootCrateId      = ID.npc.C3_LOOT_CRATE,
})

local damageReduction = { [0] = -5000, [1] = -4250, [2] = -3000, [3] = -2250, [4] = -1500, [5] = -750, [6] = 0 }

function content:handleEscortDeath(bossName, battlefield, mob, count)
    local boss = mob:getZone():queryEntitiesByName(bossName)[1]

    boss:setMod(xi.mod.DMG, damageReduction[count])
end

function content:handleStrengthenBosses(bonusMods, amount, battlefield, mob, count)
    local bosses = { 'Abyssdweller_Jhabdebb', 'Orichalcum_Quadav', 'Pee_Qoho_the_Python' }

    for _, name in ipairs(bosses) do
        local boss = mob:getZone():queryEntitiesByName(name)[1]

        if boss:isAlive() then
            boss:injectActionPacket(boss:getID(), 11, 439, 0, 24, 0, 307, 0)

            for _, bonusMod in ipairs(bonusMods) do
                boss:setMod(bonusMod, amount)
            end
        end
    end
end

content.groups =
{
    {
        mobs =
        {
            'Abyssdweller_Jhabdebb',
            'Orichalcum_Quadav',
            'Pee_Qoho_the_Python',
            'Grognard_Mesmerizer',
            'Grognard_Footsoldier',
            'Grognard_Predator',
            'Grognard_Neckchopper',
            'Grognard_Grappler',
            'Grognard_Impaler',
            'Star_Ruby_Quadav',
            'Fossil_Quadav',
            'Whitegold_Quadav',
            'Wootz_Quadav',
            'Star_Sapphire_Quadav',
            'Lightsteel_Quadav',
            'Yagudo_Archpriest',
            'Yagudo_Disciplinant',
            'Yagudo_Kapellmeister',
            'Yagudo_Knight_Templar',
            'Yagudo_Prelatess',
            'Yagudo_Eradicator',
        },

        mixins = { require('scripts/mixins/job_special') }
    },

    {
        mobs    = { 'Yagudos_Avatar' },
        mixins  = { require('scripts/mixins/families/avatar') },
        spawned = false,
    },

    {
        mobs =
        {
            'Yagudos_Elemental',
            'Yagudos_Avatar',
            'Orcs_Wyvern',
        },
        spawned = false,
    },

    {
        mobs =
        {
            'Grognard_Mesmerizer',
            'Grognard_Footsoldier',
            'Grognard_Predator',
            'Grognard_Neckchopper',
            'Grognard_Grappler',
            'Grognard_Impaler',
        },

        isParty = true,
        death   = utils.bind(content.handleEscortDeath, content, 'Abyssdweller_Jhabdebb'),
    },

    {
        mobs =
        {
            'Star_Ruby_Quadav',
            'Fossil_Quadav',
            'Whitegold_Quadav',
            'Wootz_Quadav',
            'Star_Sapphire_Quadav',
            'Lightsteel_Quadav',
        },

        isParty = true,
        death   = utils.bind(content.handleEscortDeath, content, 'Orichalcum_Quadav'),
    },

    {
        mobs =
        {
            'Yagudo_Archpriest',
            'Yagudo_Disciplinant',
            'Yagudo_Kapellmeister',
            'Yagudo_Knight_Templar',
            'Yagudo_Prelatess',
            'Yagudo_Eradicator',
        },

        isParty = true,
        death   = utils.bind(content.handleEscortDeath, content, 'Pee_Qoho_the_Python'),
    },

    {
        mobs  = { 'Abyssdweller_Jhabdebb' },
        death = utils.bind(content.handleStrengthenBosses, content, { xi.mod.ATTP }, 50),
    },

    {
        mobs  = { 'Orichalcum_Quadav' },
        death = utils.bind(content.handleStrengthenBosses, content, { xi.mod.UDMGPHYS, xi.mod.UDMGRANGE }, -5000),
    },

    {
        mobs  = { 'Pee_Qoho_the_Python' },
        death = utils.bind(content.handleStrengthenBosses, content, { xi.mod.UDMGMAGIC, xi.mod.UDMGBREATH }, -5000),
    },

    {
        mobs =
        {
            'Abyssdweller_Jhabdebb',
            'Orichalcum_Quadav',
            'Pee_Qoho_the_Python',
        },

        mods =
        {
            [xi.mod.REGAIN      ] = 150,
            [xi.mobMod.DETECTION] = xi.detects.HEARING,
        },

        isParty  = true,
        allDeath = function(battlefield, mob)
            npcUtil.showCrate(GetEntityByID(ID.npc.C3_LOOT_CRATE))
        end
    },

}

content.loot =
{
    [ID.npc.C3_LOOT_CRATE] =
    {
        {
            quantity = 4,
            { itemId = xi.item.ANCIENT_BEASTCOIN,        weight = 10000 },
        },

        {
            { itemId = xi.item.UTOPIAN_GOLD_THREAD,      weight =  2500 }, -- MNK
            { itemId = xi.item.SQUARE_OF_SUPPLE_SKIN,    weight =  2500 }, -- THF
            { itemId = xi.item.SPOOL_OF_SILKWORM_THREAD, weight =  2500 }, -- COR
          --{ itemId = xi.item.SQUARE_OF_BRILLIANTINE,   weight =  2500 }, -- SCH
        },

        {
            { itemId = xi.item.PLAITED_CORD,             weight =  2500 }, -- NIN
            { itemId = xi.item.SHEET_OF_COBALT_MYTHRIL,  weight =  2500 }, -- DRG
            { itemId = xi.item.SQUARE_OF_BENEDICT_SILK,  weight =  2500 }, -- WHM
          --{ itemId = xi.item.SQUARE_OF_FILET_LACE,     weight =  2500 }, -- DNC
        },

        {
            { itemId = xi.item.SILVER_CHIP,              weight = 10000 },
        },

        {
            { itemId = xi.item.NONE,                     weight =  9000 },
            { itemId = xi.item.METAL_CHIP,               weight =  1000 },
        },
    }
}

return content:register()
